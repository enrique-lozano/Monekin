import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/database/services/app-data/app_data_service.dart';
import 'package:monekin/core/models/transaction/transaction.dart';
import 'package:monekin/core/utils/logger.dart';
import 'package:path/path.dart' as path;

class BackupDatabaseService {
  AppDB db = AppDB.instance;

  File createAndReturnFile({
    required String exportPath,
    required String fileName,
  }) {
    String downloadPath = path.join(exportPath, fileName);

    File downloadFile = File(downloadPath);

    if (!downloadFile.existsSync()) {
      downloadFile.createSync(recursive: true);
    }

    return downloadFile;
  }

  Future<File> exportDatabaseFile(String exportPath) async {
    List<int> dbFileInBytes = await getDbFileInBytes();

    final file = createAndReturnFile(
      exportPath: exportPath,
      fileName:
          "monekin-${DateFormat('yyyyMMdd-Hms').format(DateTime.now())}.db",
    );

    return file.writeAsBytes(dbFileInBytes, mode: FileMode.write);
  }

  Future<Uint8List> getDbFileInBytes() async =>
      File(await db.databasePath).readAsBytes();

  String createCsvFromTransactions(
    List<MoneyTransaction> data, {
    String format = 'csv',
    String fieldSeparator = ',',
    String listSeparator = ';',
  }) {
    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final processedData = <List<String?>>[
      // Header
      [
        'ID',
        'Amount',
        'Date',
        'Title',
        'Note',
        'Account',
        'Currency',
        'Category',
        'Subcategory',
        'Tags',
      ],
    ];

    for (final transaction in data) {
      final toAdd = [
        // ID
        transaction.id,
        // Amount
        transaction.value.toStringAsFixed(2),
        // Date
        dateFormatter.format(transaction.date),
        // Title
        transaction.title ?? '',
        // Notes
        transaction.notes ?? '',
        // Account
        transaction.account.name,
        // Currency
        transaction.account.currencyId,
        // Category
        if (transaction.isIncomeOrExpense)
          (transaction.category!.parentCategory != null
              ? transaction.category!.parentCategory!.name
              : transaction.category!.name),
        // Subcategory
        if (transaction.isTransfer) 'TRANSFER',
        (transaction.category?.parentCategory != null
            ? transaction.category?.name
            : ''),
        // Tags
        transaction.tags.map((e) => e.name).join(listSeparator),
      ];
      processedData.add(toAdd);

      if (transaction.isTransfer) {
        processedData.add(toAdd);
      }
    }
    final csvData = ListToCsvConverter().convert(processedData);
    return csvData;
  }

  Future<File> exportSpreadsheet(
    String exportPath,
    List<MoneyTransaction> data,
  ) async {
    final csvData = createCsvFromTransactions(data);

    final file = createAndReturnFile(
      exportPath: exportPath,
      fileName:
          "Transactions-${DateFormat('yyyyMMdd-HHmmss').format(DateTime.now())}.csv",
    );

    return file.writeAsString(csvData, mode: FileMode.writeOnly);
  }

  /// Imports a database file selected by the user. Returns true if the import was successful,
  /// false if no file was selected.
  Future<bool> importDatabase() async {
    final selectedFile = await pickAndReadSingleFile(
      type: Platform.isWindows ? FileType.custom : FileType.any,
      allowedExtensions: Platform.isWindows ? ['db'] : null,
    );

    if (selectedFile == null) {
      return false;
    }

    // Delete the previous database
    String dbPath = await db.databasePath;

    final currentDBContent = await File(dbPath).readAsBytes();

    // Load the new database
    await File(
      dbPath,
    ).writeAsBytes(await selectedFile.readAsBytes(), mode: FileMode.write);

    try {
      final dbVersion = int.parse(
        (await AppDataService.instance
            .getAppDataItem(AppDataKey.dbVersion)
            .first)!,
      );

      if (dbVersion < db.schemaVersion) {
        await db.migrateDB(dbVersion, db.schemaVersion);
      }

      db.markTablesUpdated(db.allTables);
    } catch (e) {
      // Reset the DB as it was
      await File(dbPath).writeAsBytes(currentDBContent, mode: FileMode.write);
      db.markTablesUpdated(db.allTables);

      Logger.printDebug('Error\n: $e');

      throw Exception('The database is invalid or could not be readed');
    }

    return true;
  }

  Future<File?> pickAndReadSingleFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
    );

    if (result == null) {
      return null;
    }

    return File(result.files.single.path!);
  }

  Future<List<List<String>>> processCsv(String csvData) async {
    return const CsvToListConverter().convert(
      csvData,
      csvSettingsDetector: const FirstOccurrenceSettingsDetector(
        fieldDelimiters: [',', ';', '\t', '|'],
        textDelimiters: ['"', "'"],
        eols: ['\r\n', '\n'],
      ),
      shouldParseNumbers: false,
    );
  }
}
