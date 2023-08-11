import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:http/http.dart' as http;
import 'package:sqlite3/wasm.dart';

DatabaseConnection connect(
  String dbName, {
  bool logStatements = false,
  bool inMemory = false,
}) {
  return DatabaseConnection.delayed(Future.sync(() async {
    final response = await http.get(Uri.parse('sqlite3.wasm'));
    final fs = await IndexedDbFileSystem.open(dbName: '/db/');
    final sqlite3 = await WasmSqlite3.load(response.bodyBytes);
    if (inMemory) {
      return DatabaseConnection(WasmDatabase.inMemory(
        sqlite3,
        logStatements: logStatements,
      ));
    } else {
      final path = '/drift/db/$dbName';
      return DatabaseConnection(WasmDatabase(
        sqlite3: sqlite3,
        path: path,
        fileSystem: fs,
        logStatements: logStatements,
      ));
    }
  }));
}
