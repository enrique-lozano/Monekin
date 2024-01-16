// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class Currencies extends Table with TableInfo<Currencies, CurrencyInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Currencies(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
      'symbol', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [code, symbol];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencies';
  @override
  VerificationContext validateIntegrity(Insertable<CurrencyInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrencyInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyInDB(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      symbol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symbol'])!,
    );
  }

  @override
  Currencies createAlias(String alias) {
    return Currencies(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CurrencyInDB extends DataClass implements Insertable<CurrencyInDB> {
  /// ISO 4217 currency code. Identifies a currency uniquely ([see more](https://en.wikipedia.org/wiki/ISO_4217#List_of_ISO_4217_currency_codes))
  final String code;

  /// Symbol to represent the currency
  final String symbol;
  const CurrencyInDB({required this.code, required this.symbol});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['symbol'] = Variable<String>(symbol);
    return map;
  }

  CurrenciesCompanion toCompanion(bool nullToAbsent) {
    return CurrenciesCompanion(
      code: Value(code),
      symbol: Value(symbol),
    );
  }

  factory CurrencyInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyInDB(
      code: serializer.fromJson<String>(json['code']),
      symbol: serializer.fromJson<String>(json['symbol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'symbol': serializer.toJson<String>(symbol),
    };
  }

  CurrencyInDB copyWith({String? code, String? symbol}) => CurrencyInDB(
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
      );
  @override
  String toString() {
    return (StringBuffer('CurrencyInDB(')
          ..write('code: $code, ')
          ..write('symbol: $symbol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, symbol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyInDB &&
          other.code == this.code &&
          other.symbol == this.symbol);
}

class CurrenciesCompanion extends UpdateCompanion<CurrencyInDB> {
  final Value<String> code;
  final Value<String> symbol;
  final Value<int> rowid;
  const CurrenciesCompanion({
    this.code = const Value.absent(),
    this.symbol = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrenciesCompanion.insert({
    required String code,
    required String symbol,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        symbol = Value(symbol);
  static Insertable<CurrencyInDB> custom({
    Expression<String>? code,
    Expression<String>? symbol,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (symbol != null) 'symbol': symbol,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrenciesCompanion copyWith(
      {Value<String>? code, Value<String>? symbol, Value<int>? rowid}) {
    return CurrenciesCompanion(
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrenciesCompanion(')
          ..write('code: $code, ')
          ..write('symbol: $symbol, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Accounts extends Table with TableInfo<Accounts, AccountInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Accounts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _iniValueMeta =
      const VerificationMeta('iniValue');
  late final GeneratedColumn<double> iniValue = GeneratedColumn<double>(
      'iniValue', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<AccountType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints:
                  'NOT NULL CHECK (type IN (\'normal\', \'saving\'))')
          .withConverter<AccountType>(Accounts.$convertertype);
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
      'iconId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _closingDateMeta =
      const VerificationMeta('closingDate');
  late final GeneratedColumn<DateTime> closingDate = GeneratedColumn<DateTime>(
      'closingDate', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _currencyIdMeta =
      const VerificationMeta('currencyId');
  late final GeneratedColumn<String> currencyId = GeneratedColumn<String>(
      'currencyId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES currencies(code)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _ibanMeta = const VerificationMeta('iban');
  late final GeneratedColumn<String> iban = GeneratedColumn<String>(
      'iban', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _swiftMeta = const VerificationMeta('swift');
  late final GeneratedColumn<String> swift = GeneratedColumn<String>(
      'swift', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        iniValue,
        date,
        description,
        type,
        iconId,
        color,
        closingDate,
        currencyId,
        iban,
        swift
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<AccountInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('iniValue')) {
      context.handle(_iniValueMeta,
          iniValue.isAcceptableOrUnknown(data['iniValue']!, _iniValueMeta));
    } else if (isInserting) {
      context.missing(_iniValueMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('iconId')) {
      context.handle(_iconIdMeta,
          iconId.isAcceptableOrUnknown(data['iconId']!, _iconIdMeta));
    } else if (isInserting) {
      context.missing(_iconIdMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('closingDate')) {
      context.handle(
          _closingDateMeta,
          closingDate.isAcceptableOrUnknown(
              data['closingDate']!, _closingDateMeta));
    }
    if (data.containsKey('currencyId')) {
      context.handle(
          _currencyIdMeta,
          currencyId.isAcceptableOrUnknown(
              data['currencyId']!, _currencyIdMeta));
    } else if (isInserting) {
      context.missing(_currencyIdMeta);
    }
    if (data.containsKey('iban')) {
      context.handle(
          _ibanMeta, iban.isAcceptableOrUnknown(data['iban']!, _ibanMeta));
    }
    if (data.containsKey('swift')) {
      context.handle(
          _swiftMeta, swift.isAcceptableOrUnknown(data['swift']!, _swiftMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iniValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}iniValue'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: Accounts.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      iconId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iconId'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      closingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closingDate']),
      currencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currencyId'])!,
      iban: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iban']),
      swift: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}swift']),
    );
  }

  @override
  Accounts createAlias(String alias) {
    return Accounts(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountType, String, String> $convertertype =
      const EnumNameConverter<AccountType>(AccountType.values);
  @override
  bool get dontWriteConstraints => true;
}

class AccountInDB extends DataClass implements Insertable<AccountInDB> {
  final String id;

  /// Account name (unique among user accounts)
  final String name;
  final double iniValue;

  /// Creation/Opening date of this account. Before this date, no transactions can exists on it.
  final DateTime date;
  final String? description;
  final AccountType type;
  final String iconId;

  /// If null, an automatic color will be applied
  final String? color;

  /// The closing date of the account. After this date, no transactions can exists on it.
  final DateTime? closingDate;

  /// ID of the currency used by this account and therefore all transactions contained in it
  final String currencyId;
  final String? iban;
  final String? swift;
  const AccountInDB(
      {required this.id,
      required this.name,
      required this.iniValue,
      required this.date,
      this.description,
      required this.type,
      required this.iconId,
      this.color,
      this.closingDate,
      required this.currencyId,
      this.iban,
      this.swift});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['iniValue'] = Variable<double>(iniValue);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      final converter = Accounts.$convertertype;
      map['type'] = Variable<String>(converter.toSql(type));
    }
    map['iconId'] = Variable<String>(iconId);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || closingDate != null) {
      map['closingDate'] = Variable<DateTime>(closingDate);
    }
    map['currencyId'] = Variable<String>(currencyId);
    if (!nullToAbsent || iban != null) {
      map['iban'] = Variable<String>(iban);
    }
    if (!nullToAbsent || swift != null) {
      map['swift'] = Variable<String>(swift);
    }
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      iniValue: Value(iniValue),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      iconId: Value(iconId),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      closingDate: closingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(closingDate),
      currencyId: Value(currencyId),
      iban: iban == null && nullToAbsent ? const Value.absent() : Value(iban),
      swift:
          swift == null && nullToAbsent ? const Value.absent() : Value(swift),
    );
  }

  factory AccountInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountInDB(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iniValue: serializer.fromJson<double>(json['iniValue']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      type: Accounts.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      iconId: serializer.fromJson<String>(json['iconId']),
      color: serializer.fromJson<String?>(json['color']),
      closingDate: serializer.fromJson<DateTime?>(json['closingDate']),
      currencyId: serializer.fromJson<String>(json['currencyId']),
      iban: serializer.fromJson<String?>(json['iban']),
      swift: serializer.fromJson<String?>(json['swift']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iniValue': serializer.toJson<double>(iniValue),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(Accounts.$convertertype.toJson(type)),
      'iconId': serializer.toJson<String>(iconId),
      'color': serializer.toJson<String?>(color),
      'closingDate': serializer.toJson<DateTime?>(closingDate),
      'currencyId': serializer.toJson<String>(currencyId),
      'iban': serializer.toJson<String?>(iban),
      'swift': serializer.toJson<String?>(swift),
    };
  }

  AccountInDB copyWith(
          {String? id,
          String? name,
          double? iniValue,
          DateTime? date,
          Value<String?> description = const Value.absent(),
          AccountType? type,
          String? iconId,
          Value<String?> color = const Value.absent(),
          Value<DateTime?> closingDate = const Value.absent(),
          String? currencyId,
          Value<String?> iban = const Value.absent(),
          Value<String?> swift = const Value.absent()}) =>
      AccountInDB(
        id: id ?? this.id,
        name: name ?? this.name,
        iniValue: iniValue ?? this.iniValue,
        date: date ?? this.date,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
        iconId: iconId ?? this.iconId,
        color: color.present ? color.value : this.color,
        closingDate: closingDate.present ? closingDate.value : this.closingDate,
        currencyId: currencyId ?? this.currencyId,
        iban: iban.present ? iban.value : this.iban,
        swift: swift.present ? swift.value : this.swift,
      );
  @override
  String toString() {
    return (StringBuffer('AccountInDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iniValue: $iniValue, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('iconId: $iconId, ')
          ..write('color: $color, ')
          ..write('closingDate: $closingDate, ')
          ..write('currencyId: $currencyId, ')
          ..write('iban: $iban, ')
          ..write('swift: $swift')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iniValue, date, description, type,
      iconId, color, closingDate, currencyId, iban, swift);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountInDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.iniValue == this.iniValue &&
          other.date == this.date &&
          other.description == this.description &&
          other.type == this.type &&
          other.iconId == this.iconId &&
          other.color == this.color &&
          other.closingDate == this.closingDate &&
          other.currencyId == this.currencyId &&
          other.iban == this.iban &&
          other.swift == this.swift);
}

class AccountsCompanion extends UpdateCompanion<AccountInDB> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> iniValue;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<AccountType> type;
  final Value<String> iconId;
  final Value<String?> color;
  final Value<DateTime?> closingDate;
  final Value<String> currencyId;
  final Value<String?> iban;
  final Value<String?> swift;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iniValue = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.iconId = const Value.absent(),
    this.color = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.currencyId = const Value.absent(),
    this.iban = const Value.absent(),
    this.swift = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required double iniValue,
    required DateTime date,
    this.description = const Value.absent(),
    required AccountType type,
    required String iconId,
    this.color = const Value.absent(),
    this.closingDate = const Value.absent(),
    required String currencyId,
    this.iban = const Value.absent(),
    this.swift = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        iniValue = Value(iniValue),
        date = Value(date),
        type = Value(type),
        iconId = Value(iconId),
        currencyId = Value(currencyId);
  static Insertable<AccountInDB> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? iniValue,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? iconId,
    Expression<String>? color,
    Expression<DateTime>? closingDate,
    Expression<String>? currencyId,
    Expression<String>? iban,
    Expression<String>? swift,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iniValue != null) 'iniValue': iniValue,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (iconId != null) 'iconId': iconId,
      if (color != null) 'color': color,
      if (closingDate != null) 'closingDate': closingDate,
      if (currencyId != null) 'currencyId': currencyId,
      if (iban != null) 'iban': iban,
      if (swift != null) 'swift': swift,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? iniValue,
      Value<DateTime>? date,
      Value<String?>? description,
      Value<AccountType>? type,
      Value<String>? iconId,
      Value<String?>? color,
      Value<DateTime?>? closingDate,
      Value<String>? currencyId,
      Value<String?>? iban,
      Value<String?>? swift,
      Value<int>? rowid}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iniValue: iniValue ?? this.iniValue,
      date: date ?? this.date,
      description: description ?? this.description,
      type: type ?? this.type,
      iconId: iconId ?? this.iconId,
      color: color ?? this.color,
      closingDate: closingDate ?? this.closingDate,
      currencyId: currencyId ?? this.currencyId,
      iban: iban ?? this.iban,
      swift: swift ?? this.swift,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iniValue.present) {
      map['iniValue'] = Variable<double>(iniValue.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      final converter = Accounts.$convertertype;

      map['type'] = Variable<String>(converter.toSql(type.value));
    }
    if (iconId.present) {
      map['iconId'] = Variable<String>(iconId.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (closingDate.present) {
      map['closingDate'] = Variable<DateTime>(closingDate.value);
    }
    if (currencyId.present) {
      map['currencyId'] = Variable<String>(currencyId.value);
    }
    if (iban.present) {
      map['iban'] = Variable<String>(iban.value);
    }
    if (swift.present) {
      map['swift'] = Variable<String>(swift.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iniValue: $iniValue, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('iconId: $iconId, ')
          ..write('color: $color, ')
          ..write('closingDate: $closingDate, ')
          ..write('currencyId: $currencyId, ')
          ..write('iban: $iban, ')
          ..write('swift: $swift, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Categories extends Table with TableInfo<Categories, CategoryInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
      'iconId', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumnWithTypeConverter<CategoryType?, String> type =
      GeneratedColumn<String>('type', aliasedName, true,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              $customConstraints: 'CHECK (type IN (\'E\', \'I\', \'B\'))')
          .withConverter<CategoryType?>(Categories.$convertertypen);
  static const VerificationMeta _parentCategoryIDMeta =
      const VerificationMeta('parentCategoryID');
  late final GeneratedColumn<String> parentCategoryID = GeneratedColumn<String>(
      'parentCategoryID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES categories(id)ON UPDATE CASCADE ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, iconId, color, type, parentCategoryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('iconId')) {
      context.handle(_iconIdMeta,
          iconId.isAcceptableOrUnknown(data['iconId']!, _iconIdMeta));
    } else if (isInserting) {
      context.missing(_iconIdMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('parentCategoryID')) {
      context.handle(
          _parentCategoryIDMeta,
          parentCategoryID.isAcceptableOrUnknown(
              data['parentCategoryID']!, _parentCategoryIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      iconId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}iconId'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      type: Categories.$convertertypen.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])),
      parentCategoryID: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}parentCategoryID']),
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryType, String, String> $convertertype =
      const EnumNameConverter<CategoryType>(CategoryType.values);
  static JsonTypeConverter2<CategoryType?, String?, String?> $convertertypen =
      JsonTypeConverter2.asNullable($convertertype);
  @override
  List<String> get customConstraints => const [
        'CHECK((parentCategoryID IS NULL)!=(color IS NULL AND type IS NULL))',
        'CHECK((color IS NULL)==(type IS NULL))'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CategoryInDB extends DataClass implements Insertable<CategoryInDB> {
  final String id;

  /// The name of the category
  final String name;

  /// Id of the icon that represents this category
  final String iconId;

  /// Color that will be used to represent this category in some screens. If null, the color of the parent's category will be used
  final String? color;

  /// Type of the category. If null, the type of the parent's category will be used
  final CategoryType? type;

  /// Parent category of this category (if any)
  final String? parentCategoryID;
  const CategoryInDB(
      {required this.id,
      required this.name,
      required this.iconId,
      this.color,
      this.type,
      this.parentCategoryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['iconId'] = Variable<String>(iconId);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || type != null) {
      final converter = Categories.$convertertypen;
      map['type'] = Variable<String>(converter.toSql(type));
    }
    if (!nullToAbsent || parentCategoryID != null) {
      map['parentCategoryID'] = Variable<String>(parentCategoryID);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      iconId: Value(iconId),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      parentCategoryID: parentCategoryID == null && nullToAbsent
          ? const Value.absent()
          : Value(parentCategoryID),
    );
  }

  factory CategoryInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryInDB(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconId: serializer.fromJson<String>(json['iconId']),
      color: serializer.fromJson<String?>(json['color']),
      type: Categories.$convertertypen
          .fromJson(serializer.fromJson<String?>(json['type'])),
      parentCategoryID: serializer.fromJson<String?>(json['parentCategoryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'iconId': serializer.toJson<String>(iconId),
      'color': serializer.toJson<String?>(color),
      'type':
          serializer.toJson<String?>(Categories.$convertertypen.toJson(type)),
      'parentCategoryID': serializer.toJson<String?>(parentCategoryID),
    };
  }

  CategoryInDB copyWith(
          {String? id,
          String? name,
          String? iconId,
          Value<String?> color = const Value.absent(),
          Value<CategoryType?> type = const Value.absent(),
          Value<String?> parentCategoryID = const Value.absent()}) =>
      CategoryInDB(
        id: id ?? this.id,
        name: name ?? this.name,
        iconId: iconId ?? this.iconId,
        color: color.present ? color.value : this.color,
        type: type.present ? type.value : this.type,
        parentCategoryID: parentCategoryID.present
            ? parentCategoryID.value
            : this.parentCategoryID,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryInDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('color: $color, ')
          ..write('type: $type, ')
          ..write('parentCategoryID: $parentCategoryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, iconId, color, type, parentCategoryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryInDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconId == this.iconId &&
          other.color == this.color &&
          other.type == this.type &&
          other.parentCategoryID == this.parentCategoryID);
}

class CategoriesCompanion extends UpdateCompanion<CategoryInDB> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> iconId;
  final Value<String?> color;
  final Value<CategoryType?> type;
  final Value<String?> parentCategoryID;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconId = const Value.absent(),
    this.color = const Value.absent(),
    this.type = const Value.absent(),
    this.parentCategoryID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String iconId,
    this.color = const Value.absent(),
    this.type = const Value.absent(),
    this.parentCategoryID = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        iconId = Value(iconId);
  static Insertable<CategoryInDB> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? iconId,
    Expression<String>? color,
    Expression<String>? type,
    Expression<String>? parentCategoryID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconId != null) 'iconId': iconId,
      if (color != null) 'color': color,
      if (type != null) 'type': type,
      if (parentCategoryID != null) 'parentCategoryID': parentCategoryID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? iconId,
      Value<String?>? color,
      Value<CategoryType?>? type,
      Value<String?>? parentCategoryID,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconId: iconId ?? this.iconId,
      color: color ?? this.color,
      type: type ?? this.type,
      parentCategoryID: parentCategoryID ?? this.parentCategoryID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconId.present) {
      map['iconId'] = Variable<String>(iconId.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (type.present) {
      final converter = Categories.$convertertypen;

      map['type'] = Variable<String>(converter.toSql(type.value));
    }
    if (parentCategoryID.present) {
      map['parentCategoryID'] = Variable<String>(parentCategoryID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('color: $color, ')
          ..write('type: $type, ')
          ..write('parentCategoryID: $parentCategoryID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Transactions extends Table with TableInfo<Transactions, TransactionInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Transactions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _accountIDMeta =
      const VerificationMeta('accountID');
  late final GeneratedColumn<String> accountID = GeneratedColumn<String>(
      'accountID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES accounts(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumnWithTypeConverter<TransactionStatus?,
      String> status = GeneratedColumn<String>('status', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints:
              'CHECK (status IN (\'voided\', \'pending\', \'reconciled\', \'unreconciled\'))')
      .withConverter<TransactionStatus?>(Transactions.$converterstatusn);
  static const VerificationMeta _categoryIDMeta =
      const VerificationMeta('categoryID');
  late final GeneratedColumn<String> categoryID = GeneratedColumn<String>(
      'categoryID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints:
          'REFERENCES categories(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _valueInDestinyMeta =
      const VerificationMeta('valueInDestiny');
  late final GeneratedColumn<double> valueInDestiny = GeneratedColumn<double>(
      'valueInDestiny', aliasedName, true,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _receivingAccountIDMeta =
      const VerificationMeta('receivingAccountID');
  late final GeneratedColumn<String> receivingAccountID =
      GeneratedColumn<String>('receivingAccountID', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints:
              'REFERENCES accounts(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _isHiddenMeta =
      const VerificationMeta('isHidden');
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
      'isHidden', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _intervalPeriodMeta =
      const VerificationMeta('intervalPeriod');
  late final GeneratedColumnWithTypeConverter<TransactionPeriodicity?,
      String> intervalPeriod = GeneratedColumn<String>(
          'intervalPeriod', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints:
              'CHECK (intervalPeriod IN (\'day\', \'week\', \'month\', \'year\'))')
      .withConverter<TransactionPeriodicity?>(
          Transactions.$converterintervalPeriodn);
  static const VerificationMeta _intervalEachMeta =
      const VerificationMeta('intervalEach');
  late final GeneratedColumn<int> intervalEach = GeneratedColumn<int>(
      'intervalEach', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'endDate', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remainingTransactionsMeta =
      const VerificationMeta('remainingTransactions');
  late final GeneratedColumn<int> remainingTransactions = GeneratedColumn<int>(
      'remainingTransactions', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        accountID,
        value,
        title,
        notes,
        status,
        categoryID,
        valueInDestiny,
        receivingAccountID,
        isHidden,
        intervalPeriod,
        intervalEach,
        endDate,
        remainingTransactions
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('accountID')) {
      context.handle(_accountIDMeta,
          accountID.isAcceptableOrUnknown(data['accountID']!, _accountIDMeta));
    } else if (isInserting) {
      context.missing(_accountIDMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('categoryID')) {
      context.handle(
          _categoryIDMeta,
          categoryID.isAcceptableOrUnknown(
              data['categoryID']!, _categoryIDMeta));
    }
    if (data.containsKey('valueInDestiny')) {
      context.handle(
          _valueInDestinyMeta,
          valueInDestiny.isAcceptableOrUnknown(
              data['valueInDestiny']!, _valueInDestinyMeta));
    }
    if (data.containsKey('receivingAccountID')) {
      context.handle(
          _receivingAccountIDMeta,
          receivingAccountID.isAcceptableOrUnknown(
              data['receivingAccountID']!, _receivingAccountIDMeta));
    }
    if (data.containsKey('isHidden')) {
      context.handle(_isHiddenMeta,
          isHidden.isAcceptableOrUnknown(data['isHidden']!, _isHiddenMeta));
    }
    context.handle(_intervalPeriodMeta, const VerificationResult.success());
    if (data.containsKey('intervalEach')) {
      context.handle(
          _intervalEachMeta,
          intervalEach.isAcceptableOrUnknown(
              data['intervalEach']!, _intervalEachMeta));
    }
    if (data.containsKey('endDate')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['endDate']!, _endDateMeta));
    }
    if (data.containsKey('remainingTransactions')) {
      context.handle(
          _remainingTransactionsMeta,
          remainingTransactions.isAcceptableOrUnknown(
              data['remainingTransactions']!, _remainingTransactionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      accountID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accountID'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: Transactions.$converterstatusn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])),
      categoryID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoryID']),
      valueInDestiny: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valueInDestiny']),
      receivingAccountID: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}receivingAccountID']),
      isHidden: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}isHidden'])!,
      intervalPeriod: Transactions.$converterintervalPeriodn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}intervalPeriod'])),
      intervalEach: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intervalEach']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}endDate']),
      remainingTransactions: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}remainingTransactions']),
    );
  }

  @override
  Transactions createAlias(String alias) {
    return Transactions(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionStatus, String, String>
      $converterstatus =
      const EnumNameConverter<TransactionStatus>(TransactionStatus.values);
  static JsonTypeConverter2<TransactionStatus?, String?, String?>
      $converterstatusn = JsonTypeConverter2.asNullable($converterstatus);
  static JsonTypeConverter2<TransactionPeriodicity, String, String>
      $converterintervalPeriod =
      const EnumNameConverter<TransactionPeriodicity>(
          TransactionPeriodicity.values);
  static JsonTypeConverter2<TransactionPeriodicity?, String?, String?>
      $converterintervalPeriodn =
      JsonTypeConverter2.asNullable($converterintervalPeriod);
  @override
  List<String> get customConstraints => const [
        'CHECK((receivingAccountID IS NULL)!=(categoryID IS NULL))',
        'CHECK((intervalPeriod IS NULL)==(intervalEach IS NULL))',
        'CHECK((intervalPeriod IS NOT NULL)OR(endDate IS NULL))',
        'CHECK((intervalPeriod IS NOT NULL)OR(remainingTransactions IS NULL))',
        'CHECK(categoryID IS NULL OR valueInDestiny IS NULL)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class TransactionInDB extends DataClass implements Insertable<TransactionInDB> {
  final String id;

  /// Date on which the payment of this transaction was made
  final DateTime date;
  final String accountID;

  /// Monetary amount related to this transaction, in the currency of its account
  final double value;

  /// Title or main label of this transaction. If not defined, the category name is used normally as fallback
  final String? title;

  /// Some description, notes or extra info about the transaction.
  final String? notes;
  final TransactionStatus? status;
  final String? categoryID;
  final double? valueInDestiny;
  final String? receivingAccountID;
  final bool isHidden;

  /// The time range with which new transactions to be paid will appear (weekly, monthly...)
  /// --- Recurrency data ---
  final TransactionPeriodicity? intervalPeriod;

  /// Within the time range chosen in the `intervalPeriod` attribute, every few times new transactions will appear to be paid. For example, putting a 2 here and having monthly as `intervalPeriod`, new payments will appear every two months
  final int? intervalEach;

  /// Date until which payments will continue to appear. If this field or the `remainingTransactions` field is not specified, the recurring transaction will never end.
  final DateTime? endDate;

  /// Number of payments remaining. This value must dicrease by one in the case a new payment is done within this rule. If this field or the `endDate` field is not specified, the recurring transaction will never end.
  final int? remainingTransactions;
  const TransactionInDB(
      {required this.id,
      required this.date,
      required this.accountID,
      required this.value,
      this.title,
      this.notes,
      this.status,
      this.categoryID,
      this.valueInDestiny,
      this.receivingAccountID,
      required this.isHidden,
      this.intervalPeriod,
      this.intervalEach,
      this.endDate,
      this.remainingTransactions});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['accountID'] = Variable<String>(accountID);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || status != null) {
      final converter = Transactions.$converterstatusn;
      map['status'] = Variable<String>(converter.toSql(status));
    }
    if (!nullToAbsent || categoryID != null) {
      map['categoryID'] = Variable<String>(categoryID);
    }
    if (!nullToAbsent || valueInDestiny != null) {
      map['valueInDestiny'] = Variable<double>(valueInDestiny);
    }
    if (!nullToAbsent || receivingAccountID != null) {
      map['receivingAccountID'] = Variable<String>(receivingAccountID);
    }
    map['isHidden'] = Variable<bool>(isHidden);
    if (!nullToAbsent || intervalPeriod != null) {
      final converter = Transactions.$converterintervalPeriodn;
      map['intervalPeriod'] = Variable<String>(converter.toSql(intervalPeriod));
    }
    if (!nullToAbsent || intervalEach != null) {
      map['intervalEach'] = Variable<int>(intervalEach);
    }
    if (!nullToAbsent || endDate != null) {
      map['endDate'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || remainingTransactions != null) {
      map['remainingTransactions'] = Variable<int>(remainingTransactions);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: Value(date),
      accountID: Value(accountID),
      value: Value(value),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      categoryID: categoryID == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryID),
      valueInDestiny: valueInDestiny == null && nullToAbsent
          ? const Value.absent()
          : Value(valueInDestiny),
      receivingAccountID: receivingAccountID == null && nullToAbsent
          ? const Value.absent()
          : Value(receivingAccountID),
      isHidden: Value(isHidden),
      intervalPeriod: intervalPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalPeriod),
      intervalEach: intervalEach == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalEach),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      remainingTransactions: remainingTransactions == null && nullToAbsent
          ? const Value.absent()
          : Value(remainingTransactions),
    );
  }

  factory TransactionInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionInDB(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      accountID: serializer.fromJson<String>(json['accountID']),
      value: serializer.fromJson<double>(json['value']),
      title: serializer.fromJson<String?>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: Transactions.$converterstatusn
          .fromJson(serializer.fromJson<String?>(json['status'])),
      categoryID: serializer.fromJson<String?>(json['categoryID']),
      valueInDestiny: serializer.fromJson<double?>(json['valueInDestiny']),
      receivingAccountID:
          serializer.fromJson<String?>(json['receivingAccountID']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      intervalPeriod: Transactions.$converterintervalPeriodn
          .fromJson(serializer.fromJson<String?>(json['intervalPeriod'])),
      intervalEach: serializer.fromJson<int?>(json['intervalEach']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      remainingTransactions:
          serializer.fromJson<int?>(json['remainingTransactions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'accountID': serializer.toJson<String>(accountID),
      'value': serializer.toJson<double>(value),
      'title': serializer.toJson<String?>(title),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer
          .toJson<String?>(Transactions.$converterstatusn.toJson(status)),
      'categoryID': serializer.toJson<String?>(categoryID),
      'valueInDestiny': serializer.toJson<double?>(valueInDestiny),
      'receivingAccountID': serializer.toJson<String?>(receivingAccountID),
      'isHidden': serializer.toJson<bool>(isHidden),
      'intervalPeriod': serializer.toJson<String?>(
          Transactions.$converterintervalPeriodn.toJson(intervalPeriod)),
      'intervalEach': serializer.toJson<int?>(intervalEach),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'remainingTransactions': serializer.toJson<int?>(remainingTransactions),
    };
  }

  TransactionInDB copyWith(
          {String? id,
          DateTime? date,
          String? accountID,
          double? value,
          Value<String?> title = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<TransactionStatus?> status = const Value.absent(),
          Value<String?> categoryID = const Value.absent(),
          Value<double?> valueInDestiny = const Value.absent(),
          Value<String?> receivingAccountID = const Value.absent(),
          bool? isHidden,
          Value<TransactionPeriodicity?> intervalPeriod = const Value.absent(),
          Value<int?> intervalEach = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<int?> remainingTransactions = const Value.absent()}) =>
      TransactionInDB(
        id: id ?? this.id,
        date: date ?? this.date,
        accountID: accountID ?? this.accountID,
        value: value ?? this.value,
        title: title.present ? title.value : this.title,
        notes: notes.present ? notes.value : this.notes,
        status: status.present ? status.value : this.status,
        categoryID: categoryID.present ? categoryID.value : this.categoryID,
        valueInDestiny:
            valueInDestiny.present ? valueInDestiny.value : this.valueInDestiny,
        receivingAccountID: receivingAccountID.present
            ? receivingAccountID.value
            : this.receivingAccountID,
        isHidden: isHidden ?? this.isHidden,
        intervalPeriod:
            intervalPeriod.present ? intervalPeriod.value : this.intervalPeriod,
        intervalEach:
            intervalEach.present ? intervalEach.value : this.intervalEach,
        endDate: endDate.present ? endDate.value : this.endDate,
        remainingTransactions: remainingTransactions.present
            ? remainingTransactions.value
            : this.remainingTransactions,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionInDB(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('accountID: $accountID, ')
          ..write('value: $value, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('categoryID: $categoryID, ')
          ..write('valueInDestiny: $valueInDestiny, ')
          ..write('receivingAccountID: $receivingAccountID, ')
          ..write('isHidden: $isHidden, ')
          ..write('intervalPeriod: $intervalPeriod, ')
          ..write('intervalEach: $intervalEach, ')
          ..write('endDate: $endDate, ')
          ..write('remainingTransactions: $remainingTransactions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      accountID,
      value,
      title,
      notes,
      status,
      categoryID,
      valueInDestiny,
      receivingAccountID,
      isHidden,
      intervalPeriod,
      intervalEach,
      endDate,
      remainingTransactions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionInDB &&
          other.id == this.id &&
          other.date == this.date &&
          other.accountID == this.accountID &&
          other.value == this.value &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.categoryID == this.categoryID &&
          other.valueInDestiny == this.valueInDestiny &&
          other.receivingAccountID == this.receivingAccountID &&
          other.isHidden == this.isHidden &&
          other.intervalPeriod == this.intervalPeriod &&
          other.intervalEach == this.intervalEach &&
          other.endDate == this.endDate &&
          other.remainingTransactions == this.remainingTransactions);
}

class TransactionsCompanion extends UpdateCompanion<TransactionInDB> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> accountID;
  final Value<double> value;
  final Value<String?> title;
  final Value<String?> notes;
  final Value<TransactionStatus?> status;
  final Value<String?> categoryID;
  final Value<double?> valueInDestiny;
  final Value<String?> receivingAccountID;
  final Value<bool> isHidden;
  final Value<TransactionPeriodicity?> intervalPeriod;
  final Value<int?> intervalEach;
  final Value<DateTime?> endDate;
  final Value<int?> remainingTransactions;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.accountID = const Value.absent(),
    this.value = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.categoryID = const Value.absent(),
    this.valueInDestiny = const Value.absent(),
    this.receivingAccountID = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.intervalPeriod = const Value.absent(),
    this.intervalEach = const Value.absent(),
    this.endDate = const Value.absent(),
    this.remainingTransactions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required DateTime date,
    required String accountID,
    required double value,
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.categoryID = const Value.absent(),
    this.valueInDestiny = const Value.absent(),
    this.receivingAccountID = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.intervalPeriod = const Value.absent(),
    this.intervalEach = const Value.absent(),
    this.endDate = const Value.absent(),
    this.remainingTransactions = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        accountID = Value(accountID),
        value = Value(value);
  static Insertable<TransactionInDB> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? accountID,
    Expression<double>? value,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? categoryID,
    Expression<double>? valueInDestiny,
    Expression<String>? receivingAccountID,
    Expression<bool>? isHidden,
    Expression<String>? intervalPeriod,
    Expression<int>? intervalEach,
    Expression<DateTime>? endDate,
    Expression<int>? remainingTransactions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (accountID != null) 'accountID': accountID,
      if (value != null) 'value': value,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (categoryID != null) 'categoryID': categoryID,
      if (valueInDestiny != null) 'valueInDestiny': valueInDestiny,
      if (receivingAccountID != null) 'receivingAccountID': receivingAccountID,
      if (isHidden != null) 'isHidden': isHidden,
      if (intervalPeriod != null) 'intervalPeriod': intervalPeriod,
      if (intervalEach != null) 'intervalEach': intervalEach,
      if (endDate != null) 'endDate': endDate,
      if (remainingTransactions != null)
        'remainingTransactions': remainingTransactions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<String>? accountID,
      Value<double>? value,
      Value<String?>? title,
      Value<String?>? notes,
      Value<TransactionStatus?>? status,
      Value<String?>? categoryID,
      Value<double?>? valueInDestiny,
      Value<String?>? receivingAccountID,
      Value<bool>? isHidden,
      Value<TransactionPeriodicity?>? intervalPeriod,
      Value<int?>? intervalEach,
      Value<DateTime?>? endDate,
      Value<int?>? remainingTransactions,
      Value<int>? rowid}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      accountID: accountID ?? this.accountID,
      value: value ?? this.value,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      categoryID: categoryID ?? this.categoryID,
      valueInDestiny: valueInDestiny ?? this.valueInDestiny,
      receivingAccountID: receivingAccountID ?? this.receivingAccountID,
      isHidden: isHidden ?? this.isHidden,
      intervalPeriod: intervalPeriod ?? this.intervalPeriod,
      intervalEach: intervalEach ?? this.intervalEach,
      endDate: endDate ?? this.endDate,
      remainingTransactions:
          remainingTransactions ?? this.remainingTransactions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (accountID.present) {
      map['accountID'] = Variable<String>(accountID.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      final converter = Transactions.$converterstatusn;

      map['status'] = Variable<String>(converter.toSql(status.value));
    }
    if (categoryID.present) {
      map['categoryID'] = Variable<String>(categoryID.value);
    }
    if (valueInDestiny.present) {
      map['valueInDestiny'] = Variable<double>(valueInDestiny.value);
    }
    if (receivingAccountID.present) {
      map['receivingAccountID'] = Variable<String>(receivingAccountID.value);
    }
    if (isHidden.present) {
      map['isHidden'] = Variable<bool>(isHidden.value);
    }
    if (intervalPeriod.present) {
      final converter = Transactions.$converterintervalPeriodn;

      map['intervalPeriod'] =
          Variable<String>(converter.toSql(intervalPeriod.value));
    }
    if (intervalEach.present) {
      map['intervalEach'] = Variable<int>(intervalEach.value);
    }
    if (endDate.present) {
      map['endDate'] = Variable<DateTime>(endDate.value);
    }
    if (remainingTransactions.present) {
      map['remainingTransactions'] = Variable<int>(remainingTransactions.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('accountID: $accountID, ')
          ..write('value: $value, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('categoryID: $categoryID, ')
          ..write('valueInDestiny: $valueInDestiny, ')
          ..write('receivingAccountID: $receivingAccountID, ')
          ..write('isHidden: $isHidden, ')
          ..write('intervalPeriod: $intervalPeriod, ')
          ..write('intervalEach: $intervalEach, ')
          ..write('endDate: $endDate, ')
          ..write('remainingTransactions: $remainingTransactions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ExchangeRates extends Table
    with TableInfo<ExchangeRates, ExchangeRateInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ExchangeRates(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currencyCode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES currencies(code)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _exchangeRateMeta =
      const VerificationMeta('exchangeRate');
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
      'exchangeRate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, date, currencyCode, exchangeRate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchangeRates';
  @override
  VerificationContext validateIntegrity(Insertable<ExchangeRateInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('currencyCode')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currencyCode']!, _currencyCodeMeta));
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('exchangeRate')) {
      context.handle(
          _exchangeRateMeta,
          exchangeRate.isAcceptableOrUnknown(
              data['exchangeRate']!, _exchangeRateMeta));
    } else if (isInserting) {
      context.missing(_exchangeRateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRateInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRateInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currencyCode'])!,
      exchangeRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}exchangeRate'])!,
    );
  }

  @override
  ExchangeRates createAlias(String alias) {
    return ExchangeRates(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ExchangeRateInDB extends DataClass
    implements Insertable<ExchangeRateInDB> {
  final String id;
  final DateTime date;
  final String currencyCode;
  final double exchangeRate;
  const ExchangeRateInDB(
      {required this.id,
      required this.date,
      required this.currencyCode,
      required this.exchangeRate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['currencyCode'] = Variable<String>(currencyCode);
    map['exchangeRate'] = Variable<double>(exchangeRate);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      date: Value(date),
      currencyCode: Value(currencyCode),
      exchangeRate: Value(exchangeRate),
    );
  }

  factory ExchangeRateInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRateInDB(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
    };
  }

  ExchangeRateInDB copyWith(
          {String? id,
          DateTime? date,
          String? currencyCode,
          double? exchangeRate}) =>
      ExchangeRateInDB(
        id: id ?? this.id,
        date: date ?? this.date,
        currencyCode: currencyCode ?? this.currencyCode,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );
  @override
  String toString() {
    return (StringBuffer('ExchangeRateInDB(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('exchangeRate: $exchangeRate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, currencyCode, exchangeRate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRateInDB &&
          other.id == this.id &&
          other.date == this.date &&
          other.currencyCode == this.currencyCode &&
          other.exchangeRate == this.exchangeRate);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRateInDB> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> currencyCode;
  final Value<double> exchangeRate;
  final Value<int> rowid;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    required String id,
    required DateTime date,
    required String currencyCode,
    required double exchangeRate,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        currencyCode = Value(currencyCode),
        exchangeRate = Value(exchangeRate);
  static Insertable<ExchangeRateInDB> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? currencyCode,
    Expression<double>? exchangeRate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (currencyCode != null) 'currencyCode': currencyCode,
      if (exchangeRate != null) 'exchangeRate': exchangeRate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExchangeRatesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<String>? currencyCode,
      Value<double>? exchangeRate,
      Value<int>? rowid}) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      currencyCode: currencyCode ?? this.currencyCode,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (currencyCode.present) {
      map['currencyCode'] = Variable<String>(currencyCode.value);
    }
    if (exchangeRate.present) {
      map['exchangeRate'] = Variable<double>(exchangeRate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Tags extends Table with TableInfo<Tags, TagInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Tags(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, color, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<TagInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  Tags createAlias(String alias) {
    return Tags(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TagInDB extends DataClass implements Insertable<TagInDB> {
  final String id;

  /// The name of the tag
  final String name;

  /// The display color of the tag
  final String color;

  /// The description of the tag
  final String? description;
  const TagInDB(
      {required this.id,
      required this.name,
      required this.color,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory TagInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagInDB(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'description': serializer.toJson<String?>(description),
    };
  }

  TagInDB copyWith(
          {String? id,
          String? name,
          String? color,
          Value<String?> description = const Value.absent()}) =>
      TagInDB(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('TagInDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagInDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.description == this.description);
}

class TagsCompanion extends UpdateCompanion<TagInDB> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  final Value<String?> description;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String name,
    required String color,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        color = Value(color);
  static Insertable<TagInDB> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? color,
      Value<String?>? description,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TransactionTags extends Table
    with TableInfo<TransactionTags, TransactionTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TransactionTags(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transactionIDMeta =
      const VerificationMeta('transactionID');
  late final GeneratedColumn<String> transactionID = GeneratedColumn<String>(
      'transactionID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES transactions(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _tagIDMeta = const VerificationMeta('tagID');
  late final GeneratedColumn<String> tagID = GeneratedColumn<String>(
      'tagID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES tags(id)ON UPDATE CASCADE ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [transactionID, tagID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactionTags';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transactionID')) {
      context.handle(
          _transactionIDMeta,
          transactionID.isAcceptableOrUnknown(
              data['transactionID']!, _transactionIDMeta));
    } else if (isInserting) {
      context.missing(_transactionIDMeta);
    }
    if (data.containsKey('tagID')) {
      context.handle(
          _tagIDMeta, tagID.isAcceptableOrUnknown(data['tagID']!, _tagIDMeta));
    } else if (isInserting) {
      context.missing(_tagIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TransactionTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionTag(
      transactionID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transactionID'])!,
      tagID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tagID'])!,
    );
  }

  @override
  TransactionTags createAlias(String alias) {
    return TransactionTags(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TransactionTag extends DataClass implements Insertable<TransactionTag> {
  final String transactionID;
  final String tagID;
  const TransactionTag({required this.transactionID, required this.tagID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transactionID'] = Variable<String>(transactionID);
    map['tagID'] = Variable<String>(tagID);
    return map;
  }

  TransactionTagsCompanion toCompanion(bool nullToAbsent) {
    return TransactionTagsCompanion(
      transactionID: Value(transactionID),
      tagID: Value(tagID),
    );
  }

  factory TransactionTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTag(
      transactionID: serializer.fromJson<String>(json['transactionID']),
      tagID: serializer.fromJson<String>(json['tagID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionID': serializer.toJson<String>(transactionID),
      'tagID': serializer.toJson<String>(tagID),
    };
  }

  TransactionTag copyWith({String? transactionID, String? tagID}) =>
      TransactionTag(
        transactionID: transactionID ?? this.transactionID,
        tagID: tagID ?? this.tagID,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionTag(')
          ..write('transactionID: $transactionID, ')
          ..write('tagID: $tagID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(transactionID, tagID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionTag &&
          other.transactionID == this.transactionID &&
          other.tagID == this.tagID);
}

class TransactionTagsCompanion extends UpdateCompanion<TransactionTag> {
  final Value<String> transactionID;
  final Value<String> tagID;
  final Value<int> rowid;
  const TransactionTagsCompanion({
    this.transactionID = const Value.absent(),
    this.tagID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionTagsCompanion.insert({
    required String transactionID,
    required String tagID,
    this.rowid = const Value.absent(),
  })  : transactionID = Value(transactionID),
        tagID = Value(tagID);
  static Insertable<TransactionTag> custom({
    Expression<String>? transactionID,
    Expression<String>? tagID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transactionID != null) 'transactionID': transactionID,
      if (tagID != null) 'tagID': tagID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionTagsCompanion copyWith(
      {Value<String>? transactionID, Value<String>? tagID, Value<int>? rowid}) {
    return TransactionTagsCompanion(
      transactionID: transactionID ?? this.transactionID,
      tagID: tagID ?? this.tagID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionID.present) {
      map['transactionID'] = Variable<String>(transactionID.value);
    }
    if (tagID.present) {
      map['tagID'] = Variable<String>(tagID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTagsCompanion(')
          ..write('transactionID: $transactionID, ')
          ..write('tagID: $tagID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Budgets extends Table with TableInfo<Budgets, BudgetInDB> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Budgets(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _limitAmountMeta =
      const VerificationMeta('limitAmount');
  late final GeneratedColumn<double> limitAmount = GeneratedColumn<double>(
      'limitAmount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _intervalPeriodMeta =
      const VerificationMeta('intervalPeriod');
  late final GeneratedColumnWithTypeConverter<TransactionPeriodicity?,
      String> intervalPeriod = GeneratedColumn<String>(
          'intervalPeriod', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints:
              'CHECK (intervalPeriod IN (\'day\', \'week\', \'month\', \'year\'))')
      .withConverter<TransactionPeriodicity?>(
          Budgets.$converterintervalPeriodn);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'startDate', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'endDate', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, limitAmount, intervalPeriod, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetInDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('limitAmount')) {
      context.handle(
          _limitAmountMeta,
          limitAmount.isAcceptableOrUnknown(
              data['limitAmount']!, _limitAmountMeta));
    } else if (isInserting) {
      context.missing(_limitAmountMeta);
    }
    context.handle(_intervalPeriodMeta, const VerificationResult.success());
    if (data.containsKey('startDate')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['startDate']!, _startDateMeta));
    }
    if (data.containsKey('endDate')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['endDate']!, _endDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetInDB map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetInDB(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      limitAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}limitAmount'])!,
      intervalPeriod: Budgets.$converterintervalPeriodn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intervalPeriod'])),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}startDate']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}endDate']),
    );
  }

  @override
  Budgets createAlias(String alias) {
    return Budgets(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionPeriodicity, String, String>
      $converterintervalPeriod =
      const EnumNameConverter<TransactionPeriodicity>(
          TransactionPeriodicity.values);
  static JsonTypeConverter2<TransactionPeriodicity?, String?, String?>
      $converterintervalPeriodn =
      JsonTypeConverter2.asNullable($converterintervalPeriod);
  @override
  List<String> get customConstraints => const [
        'CHECK((startDate IS NULL AND endDate IS NULL)!=(intervalPeriod IS NULL))'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class BudgetInDB extends DataClass implements Insertable<BudgetInDB> {
  final String id;

  /// Title of the budget and its identificator. For instance, this name is unique (the user can not have another budget with the same name)
  final String name;

  ///  Maximum value that the budget takes. It will always be in the user's preferred currency
  final double limitAmount;

  /// Periodicity of the budget. If null, the budget is a single-time budget
  final TransactionPeriodicity? intervalPeriod;

  /// Custom start date. Only if the budget has no periodicity
  final DateTime? startDate;

  /// Custom end date. Only if the budget has no periodicity
  final DateTime? endDate;
  const BudgetInDB(
      {required this.id,
      required this.name,
      required this.limitAmount,
      this.intervalPeriod,
      this.startDate,
      this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['limitAmount'] = Variable<double>(limitAmount);
    if (!nullToAbsent || intervalPeriod != null) {
      final converter = Budgets.$converterintervalPeriodn;
      map['intervalPeriod'] = Variable<String>(converter.toSql(intervalPeriod));
    }
    if (!nullToAbsent || startDate != null) {
      map['startDate'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['endDate'] = Variable<DateTime>(endDate);
    }
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      name: Value(name),
      limitAmount: Value(limitAmount),
      intervalPeriod: intervalPeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalPeriod),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory BudgetInDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetInDB(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      limitAmount: serializer.fromJson<double>(json['limitAmount']),
      intervalPeriod: Budgets.$converterintervalPeriodn
          .fromJson(serializer.fromJson<String?>(json['intervalPeriod'])),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'limitAmount': serializer.toJson<double>(limitAmount),
      'intervalPeriod': serializer.toJson<String?>(
          Budgets.$converterintervalPeriodn.toJson(intervalPeriod)),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
    };
  }

  BudgetInDB copyWith(
          {String? id,
          String? name,
          double? limitAmount,
          Value<TransactionPeriodicity?> intervalPeriod = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent()}) =>
      BudgetInDB(
        id: id ?? this.id,
        name: name ?? this.name,
        limitAmount: limitAmount ?? this.limitAmount,
        intervalPeriod:
            intervalPeriod.present ? intervalPeriod.value : this.intervalPeriod,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
      );
  @override
  String toString() {
    return (StringBuffer('BudgetInDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('limitAmount: $limitAmount, ')
          ..write('intervalPeriod: $intervalPeriod, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, limitAmount, intervalPeriod, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetInDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.limitAmount == this.limitAmount &&
          other.intervalPeriod == this.intervalPeriod &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class BudgetsCompanion extends UpdateCompanion<BudgetInDB> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> limitAmount;
  final Value<TransactionPeriodicity?> intervalPeriod;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.limitAmount = const Value.absent(),
    this.intervalPeriod = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    required String id,
    required String name,
    required double limitAmount,
    this.intervalPeriod = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        limitAmount = Value(limitAmount);
  static Insertable<BudgetInDB> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? limitAmount,
    Expression<String>? intervalPeriod,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (limitAmount != null) 'limitAmount': limitAmount,
      if (intervalPeriod != null) 'intervalPeriod': intervalPeriod,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? limitAmount,
      Value<TransactionPeriodicity?>? intervalPeriod,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<int>? rowid}) {
    return BudgetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      limitAmount: limitAmount ?? this.limitAmount,
      intervalPeriod: intervalPeriod ?? this.intervalPeriod,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (limitAmount.present) {
      map['limitAmount'] = Variable<double>(limitAmount.value);
    }
    if (intervalPeriod.present) {
      final converter = Budgets.$converterintervalPeriodn;

      map['intervalPeriod'] =
          Variable<String>(converter.toSql(intervalPeriod.value));
    }
    if (startDate.present) {
      map['startDate'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['endDate'] = Variable<DateTime>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('limitAmount: $limitAmount, ')
          ..write('intervalPeriod: $intervalPeriod, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class BudgetCategory extends Table
    with TableInfo<BudgetCategory, BudgetCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BudgetCategory(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _budgetIDMeta =
      const VerificationMeta('budgetID');
  late final GeneratedColumn<String> budgetID = GeneratedColumn<String>(
      'budgetID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES budgets(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _categoryIDMeta =
      const VerificationMeta('categoryID');
  late final GeneratedColumn<String> categoryID = GeneratedColumn<String>(
      'categoryID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES categories(id)ON UPDATE CASCADE ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [budgetID, categoryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgetCategory';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('budgetID')) {
      context.handle(_budgetIDMeta,
          budgetID.isAcceptableOrUnknown(data['budgetID']!, _budgetIDMeta));
    } else if (isInserting) {
      context.missing(_budgetIDMeta);
    }
    if (data.containsKey('categoryID')) {
      context.handle(
          _categoryIDMeta,
          categoryID.isAcceptableOrUnknown(
              data['categoryID']!, _categoryIDMeta));
    } else if (isInserting) {
      context.missing(_categoryIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BudgetCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetCategoryData(
      budgetID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}budgetID'])!,
      categoryID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoryID'])!,
    );
  }

  @override
  BudgetCategory createAlias(String alias) {
    return BudgetCategory(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class BudgetCategoryData extends DataClass
    implements Insertable<BudgetCategoryData> {
  final String budgetID;
  final String categoryID;
  const BudgetCategoryData({required this.budgetID, required this.categoryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['budgetID'] = Variable<String>(budgetID);
    map['categoryID'] = Variable<String>(categoryID);
    return map;
  }

  BudgetCategoryCompanion toCompanion(bool nullToAbsent) {
    return BudgetCategoryCompanion(
      budgetID: Value(budgetID),
      categoryID: Value(categoryID),
    );
  }

  factory BudgetCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetCategoryData(
      budgetID: serializer.fromJson<String>(json['budgetID']),
      categoryID: serializer.fromJson<String>(json['categoryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'budgetID': serializer.toJson<String>(budgetID),
      'categoryID': serializer.toJson<String>(categoryID),
    };
  }

  BudgetCategoryData copyWith({String? budgetID, String? categoryID}) =>
      BudgetCategoryData(
        budgetID: budgetID ?? this.budgetID,
        categoryID: categoryID ?? this.categoryID,
      );
  @override
  String toString() {
    return (StringBuffer('BudgetCategoryData(')
          ..write('budgetID: $budgetID, ')
          ..write('categoryID: $categoryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(budgetID, categoryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetCategoryData &&
          other.budgetID == this.budgetID &&
          other.categoryID == this.categoryID);
}

class BudgetCategoryCompanion extends UpdateCompanion<BudgetCategoryData> {
  final Value<String> budgetID;
  final Value<String> categoryID;
  final Value<int> rowid;
  const BudgetCategoryCompanion({
    this.budgetID = const Value.absent(),
    this.categoryID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetCategoryCompanion.insert({
    required String budgetID,
    required String categoryID,
    this.rowid = const Value.absent(),
  })  : budgetID = Value(budgetID),
        categoryID = Value(categoryID);
  static Insertable<BudgetCategoryData> custom({
    Expression<String>? budgetID,
    Expression<String>? categoryID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (budgetID != null) 'budgetID': budgetID,
      if (categoryID != null) 'categoryID': categoryID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetCategoryCompanion copyWith(
      {Value<String>? budgetID, Value<String>? categoryID, Value<int>? rowid}) {
    return BudgetCategoryCompanion(
      budgetID: budgetID ?? this.budgetID,
      categoryID: categoryID ?? this.categoryID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (budgetID.present) {
      map['budgetID'] = Variable<String>(budgetID.value);
    }
    if (categoryID.present) {
      map['categoryID'] = Variable<String>(categoryID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategoryCompanion(')
          ..write('budgetID: $budgetID, ')
          ..write('categoryID: $categoryID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class BudgetAccount extends Table
    with TableInfo<BudgetAccount, BudgetAccountData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BudgetAccount(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _budgetIDMeta =
      const VerificationMeta('budgetID');
  late final GeneratedColumn<String> budgetID = GeneratedColumn<String>(
      'budgetID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES budgets(id)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _accountIDMeta =
      const VerificationMeta('accountID');
  late final GeneratedColumn<String> accountID = GeneratedColumn<String>(
      'accountID', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL REFERENCES accounts(id)ON UPDATE CASCADE ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [budgetID, accountID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgetAccount';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetAccountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('budgetID')) {
      context.handle(_budgetIDMeta,
          budgetID.isAcceptableOrUnknown(data['budgetID']!, _budgetIDMeta));
    } else if (isInserting) {
      context.missing(_budgetIDMeta);
    }
    if (data.containsKey('accountID')) {
      context.handle(_accountIDMeta,
          accountID.isAcceptableOrUnknown(data['accountID']!, _accountIDMeta));
    } else if (isInserting) {
      context.missing(_accountIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  BudgetAccountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetAccountData(
      budgetID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}budgetID'])!,
      accountID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accountID'])!,
    );
  }

  @override
  BudgetAccount createAlias(String alias) {
    return BudgetAccount(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class BudgetAccountData extends DataClass
    implements Insertable<BudgetAccountData> {
  final String budgetID;
  final String accountID;
  const BudgetAccountData({required this.budgetID, required this.accountID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['budgetID'] = Variable<String>(budgetID);
    map['accountID'] = Variable<String>(accountID);
    return map;
  }

  BudgetAccountCompanion toCompanion(bool nullToAbsent) {
    return BudgetAccountCompanion(
      budgetID: Value(budgetID),
      accountID: Value(accountID),
    );
  }

  factory BudgetAccountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetAccountData(
      budgetID: serializer.fromJson<String>(json['budgetID']),
      accountID: serializer.fromJson<String>(json['accountID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'budgetID': serializer.toJson<String>(budgetID),
      'accountID': serializer.toJson<String>(accountID),
    };
  }

  BudgetAccountData copyWith({String? budgetID, String? accountID}) =>
      BudgetAccountData(
        budgetID: budgetID ?? this.budgetID,
        accountID: accountID ?? this.accountID,
      );
  @override
  String toString() {
    return (StringBuffer('BudgetAccountData(')
          ..write('budgetID: $budgetID, ')
          ..write('accountID: $accountID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(budgetID, accountID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetAccountData &&
          other.budgetID == this.budgetID &&
          other.accountID == this.accountID);
}

class BudgetAccountCompanion extends UpdateCompanion<BudgetAccountData> {
  final Value<String> budgetID;
  final Value<String> accountID;
  final Value<int> rowid;
  const BudgetAccountCompanion({
    this.budgetID = const Value.absent(),
    this.accountID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetAccountCompanion.insert({
    required String budgetID,
    required String accountID,
    this.rowid = const Value.absent(),
  })  : budgetID = Value(budgetID),
        accountID = Value(accountID);
  static Insertable<BudgetAccountData> custom({
    Expression<String>? budgetID,
    Expression<String>? accountID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (budgetID != null) 'budgetID': budgetID,
      if (accountID != null) 'accountID': accountID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetAccountCompanion copyWith(
      {Value<String>? budgetID, Value<String>? accountID, Value<int>? rowid}) {
    return BudgetAccountCompanion(
      budgetID: budgetID ?? this.budgetID,
      accountID: accountID ?? this.accountID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (budgetID.present) {
      map['budgetID'] = Variable<String>(budgetID.value);
    }
    if (accountID.present) {
      map['accountID'] = Variable<String>(accountID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetAccountCompanion(')
          ..write('budgetID: $budgetID, ')
          ..write('accountID: $accountID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CurrencyNames extends Table with TableInfo<CurrencyNames, CurrencyName> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CurrencyNames(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currencyCode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL PRIMARY KEY REFERENCES currencies(code)ON UPDATE CASCADE ON DELETE CASCADE');
  static const VerificationMeta _enMeta = const VerificationMeta('en');
  late final GeneratedColumn<String> en = GeneratedColumn<String>(
      'en', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _esMeta = const VerificationMeta('es');
  late final GeneratedColumn<String> es = GeneratedColumn<String>(
      'es', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [currencyCode, en, es];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currencyNames';
  @override
  VerificationContext validateIntegrity(Insertable<CurrencyName> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('currencyCode')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currencyCode']!, _currencyCodeMeta));
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('en')) {
      context.handle(_enMeta, en.isAcceptableOrUnknown(data['en']!, _enMeta));
    } else if (isInserting) {
      context.missing(_enMeta);
    }
    if (data.containsKey('es')) {
      context.handle(_esMeta, es.isAcceptableOrUnknown(data['es']!, _esMeta));
    } else if (isInserting) {
      context.missing(_esMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {currencyCode};
  @override
  CurrencyName map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyName(
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currencyCode'])!,
      en: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}en'])!,
      es: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}es'])!,
    );
  }

  @override
  CurrencyNames createAlias(String alias) {
    return CurrencyNames(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CurrencyName extends DataClass implements Insertable<CurrencyName> {
  final String currencyCode;
  final String en;
  final String es;
  const CurrencyName(
      {required this.currencyCode, required this.en, required this.es});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['currencyCode'] = Variable<String>(currencyCode);
    map['en'] = Variable<String>(en);
    map['es'] = Variable<String>(es);
    return map;
  }

  CurrencyNamesCompanion toCompanion(bool nullToAbsent) {
    return CurrencyNamesCompanion(
      currencyCode: Value(currencyCode),
      en: Value(en),
      es: Value(es),
    );
  }

  factory CurrencyName.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyName(
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      en: serializer.fromJson<String>(json['en']),
      es: serializer.fromJson<String>(json['es']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'currencyCode': serializer.toJson<String>(currencyCode),
      'en': serializer.toJson<String>(en),
      'es': serializer.toJson<String>(es),
    };
  }

  CurrencyName copyWith({String? currencyCode, String? en, String? es}) =>
      CurrencyName(
        currencyCode: currencyCode ?? this.currencyCode,
        en: en ?? this.en,
        es: es ?? this.es,
      );
  @override
  String toString() {
    return (StringBuffer('CurrencyName(')
          ..write('currencyCode: $currencyCode, ')
          ..write('en: $en, ')
          ..write('es: $es')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(currencyCode, en, es);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyName &&
          other.currencyCode == this.currencyCode &&
          other.en == this.en &&
          other.es == this.es);
}

class CurrencyNamesCompanion extends UpdateCompanion<CurrencyName> {
  final Value<String> currencyCode;
  final Value<String> en;
  final Value<String> es;
  final Value<int> rowid;
  const CurrencyNamesCompanion({
    this.currencyCode = const Value.absent(),
    this.en = const Value.absent(),
    this.es = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyNamesCompanion.insert({
    required String currencyCode,
    required String en,
    required String es,
    this.rowid = const Value.absent(),
  })  : currencyCode = Value(currencyCode),
        en = Value(en),
        es = Value(es);
  static Insertable<CurrencyName> custom({
    Expression<String>? currencyCode,
    Expression<String>? en,
    Expression<String>? es,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (currencyCode != null) 'currencyCode': currencyCode,
      if (en != null) 'en': en,
      if (es != null) 'es': es,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyNamesCompanion copyWith(
      {Value<String>? currencyCode,
      Value<String>? en,
      Value<String>? es,
      Value<int>? rowid}) {
    return CurrencyNamesCompanion(
      currencyCode: currencyCode ?? this.currencyCode,
      en: en ?? this.en,
      es: es ?? this.es,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (currencyCode.present) {
      map['currencyCode'] = Variable<String>(currencyCode.value);
    }
    if (en.present) {
      map['en'] = Variable<String>(en.value);
    }
    if (es.present) {
      map['es'] = Variable<String>(es.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyNamesCompanion(')
          ..write('currencyCode: $currencyCode, ')
          ..write('en: $en, ')
          ..write('es: $es, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class UserSettings extends Table with TableInfo<UserSettings, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserSettings(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _settingKeyMeta =
      const VerificationMeta('settingKey');
  late final GeneratedColumnWithTypeConverter<SettingKey, String> settingKey =
      GeneratedColumn<String>('settingKey', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL PRIMARY KEY')
          .withConverter<SettingKey>(UserSettings.$convertersettingKey);
  static const VerificationMeta _settingValueMeta =
      const VerificationMeta('settingValue');
  late final GeneratedColumn<String> settingValue = GeneratedColumn<String>(
      'settingValue', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [settingKey, settingValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'userSettings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_settingKeyMeta, const VerificationResult.success());
    if (data.containsKey('settingValue')) {
      context.handle(
          _settingValueMeta,
          settingValue.isAcceptableOrUnknown(
              data['settingValue']!, _settingValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {settingKey};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      settingKey: UserSettings.$convertersettingKey.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settingKey'])!),
      settingValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settingValue']),
    );
  }

  @override
  UserSettings createAlias(String alias) {
    return UserSettings(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SettingKey, String, String> $convertersettingKey =
      const EnumNameConverter<SettingKey>(SettingKey.values);
  @override
  bool get dontWriteConstraints => true;
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final SettingKey settingKey;
  final String? settingValue;
  const UserSetting({required this.settingKey, this.settingValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = UserSettings.$convertersettingKey;
      map['settingKey'] = Variable<String>(converter.toSql(settingKey));
    }
    if (!nullToAbsent || settingValue != null) {
      map['settingValue'] = Variable<String>(settingValue);
    }
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      settingKey: Value(settingKey),
      settingValue: settingValue == null && nullToAbsent
          ? const Value.absent()
          : Value(settingValue),
    );
  }

  factory UserSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      settingKey: UserSettings.$convertersettingKey
          .fromJson(serializer.fromJson<String>(json['settingKey'])),
      settingValue: serializer.fromJson<String?>(json['settingValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'settingKey': serializer
          .toJson<String>(UserSettings.$convertersettingKey.toJson(settingKey)),
      'settingValue': serializer.toJson<String?>(settingValue),
    };
  }

  UserSetting copyWith(
          {SettingKey? settingKey,
          Value<String?> settingValue = const Value.absent()}) =>
      UserSetting(
        settingKey: settingKey ?? this.settingKey,
        settingValue:
            settingValue.present ? settingValue.value : this.settingValue,
      );
  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(settingKey, settingValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.settingKey == this.settingKey &&
          other.settingValue == this.settingValue);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<SettingKey> settingKey;
  final Value<String?> settingValue;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.settingKey = const Value.absent(),
    this.settingValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required SettingKey settingKey,
    this.settingValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : settingKey = Value(settingKey);
  static Insertable<UserSetting> custom({
    Expression<String>? settingKey,
    Expression<String>? settingValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (settingKey != null) 'settingKey': settingKey,
      if (settingValue != null) 'settingValue': settingValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith(
      {Value<SettingKey>? settingKey,
      Value<String?>? settingValue,
      Value<int>? rowid}) {
    return UserSettingsCompanion(
      settingKey: settingKey ?? this.settingKey,
      settingValue: settingValue ?? this.settingValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (settingKey.present) {
      final converter = UserSettings.$convertersettingKey;

      map['settingKey'] = Variable<String>(converter.toSql(settingKey.value));
    }
    if (settingValue.present) {
      map['settingValue'] = Variable<String>(settingValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('settingKey: $settingKey, ')
          ..write('settingValue: $settingValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class AppData extends Table with TableInfo<AppData, AppDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AppData(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appDataKeyMeta =
      const VerificationMeta('appDataKey');
  late final GeneratedColumnWithTypeConverter<AppDataKey, String> appDataKey =
      GeneratedColumn<String>('appDataKey', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              $customConstraints: 'NOT NULL PRIMARY KEY')
          .withConverter<AppDataKey>(AppData.$converterappDataKey);
  static const VerificationMeta _appDataValueMeta =
      const VerificationMeta('appDataValue');
  late final GeneratedColumn<String> appDataValue = GeneratedColumn<String>(
      'appDataValue', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [appDataKey, appDataValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appData';
  @override
  VerificationContext validateIntegrity(Insertable<AppDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_appDataKeyMeta, const VerificationResult.success());
    if (data.containsKey('appDataValue')) {
      context.handle(
          _appDataValueMeta,
          appDataValue.isAcceptableOrUnknown(
              data['appDataValue']!, _appDataValueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {appDataKey};
  @override
  AppDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppDataData(
      appDataKey: AppData.$converterappDataKey.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}appDataKey'])!),
      appDataValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}appDataValue']),
    );
  }

  @override
  AppData createAlias(String alias) {
    return AppData(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppDataKey, String, String> $converterappDataKey =
      const EnumNameConverter<AppDataKey>(AppDataKey.values);
  @override
  bool get dontWriteConstraints => true;
}

class AppDataData extends DataClass implements Insertable<AppDataData> {
  final AppDataKey appDataKey;
  final String? appDataValue;
  const AppDataData({required this.appDataKey, this.appDataValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      final converter = AppData.$converterappDataKey;
      map['appDataKey'] = Variable<String>(converter.toSql(appDataKey));
    }
    if (!nullToAbsent || appDataValue != null) {
      map['appDataValue'] = Variable<String>(appDataValue);
    }
    return map;
  }

  AppDataCompanion toCompanion(bool nullToAbsent) {
    return AppDataCompanion(
      appDataKey: Value(appDataKey),
      appDataValue: appDataValue == null && nullToAbsent
          ? const Value.absent()
          : Value(appDataValue),
    );
  }

  factory AppDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppDataData(
      appDataKey: AppData.$converterappDataKey
          .fromJson(serializer.fromJson<String>(json['appDataKey'])),
      appDataValue: serializer.fromJson<String?>(json['appDataValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appDataKey': serializer
          .toJson<String>(AppData.$converterappDataKey.toJson(appDataKey)),
      'appDataValue': serializer.toJson<String?>(appDataValue),
    };
  }

  AppDataData copyWith(
          {AppDataKey? appDataKey,
          Value<String?> appDataValue = const Value.absent()}) =>
      AppDataData(
        appDataKey: appDataKey ?? this.appDataKey,
        appDataValue:
            appDataValue.present ? appDataValue.value : this.appDataValue,
      );
  @override
  String toString() {
    return (StringBuffer('AppDataData(')
          ..write('appDataKey: $appDataKey, ')
          ..write('appDataValue: $appDataValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(appDataKey, appDataValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppDataData &&
          other.appDataKey == this.appDataKey &&
          other.appDataValue == this.appDataValue);
}

class AppDataCompanion extends UpdateCompanion<AppDataData> {
  final Value<AppDataKey> appDataKey;
  final Value<String?> appDataValue;
  final Value<int> rowid;
  const AppDataCompanion({
    this.appDataKey = const Value.absent(),
    this.appDataValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppDataCompanion.insert({
    required AppDataKey appDataKey,
    this.appDataValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : appDataKey = Value(appDataKey);
  static Insertable<AppDataData> custom({
    Expression<String>? appDataKey,
    Expression<String>? appDataValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appDataKey != null) 'appDataKey': appDataKey,
      if (appDataValue != null) 'appDataValue': appDataValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppDataCompanion copyWith(
      {Value<AppDataKey>? appDataKey,
      Value<String?>? appDataValue,
      Value<int>? rowid}) {
    return AppDataCompanion(
      appDataKey: appDataKey ?? this.appDataKey,
      appDataValue: appDataValue ?? this.appDataValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appDataKey.present) {
      final converter = AppData.$converterappDataKey;

      map['appDataKey'] = Variable<String>(converter.toSql(appDataKey.value));
    }
    if (appDataValue.present) {
      map['appDataValue'] = Variable<String>(appDataValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppDataCompanion(')
          ..write('appDataKey: $appDataKey, ')
          ..write('appDataValue: $appDataValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(e);
  late final Currencies currencies = Currencies(this);
  late final Accounts accounts = Accounts(this);
  late final Categories categories = Categories(this);
  late final Transactions transactions = Transactions(this);
  late final ExchangeRates exchangeRates = ExchangeRates(this);
  late final Tags tags = Tags(this);
  late final TransactionTags transactionTags = TransactionTags(this);
  late final Budgets budgets = Budgets(this);
  late final BudgetCategory budgetCategory = BudgetCategory(this);
  late final BudgetAccount budgetAccount = BudgetAccount(this);
  late final CurrencyNames currencyNames = CurrencyNames(this);
  late final UserSettings userSettings = UserSettings(this);
  late final AppData appData = AppData(this);
  Selectable<Account> getAccountsWithFullData(
      {GetAccountsWithFullData$predicate? predicate,
      GetAccountsWithFullData$orderBy? orderBy,
      required GetAccountsWithFullData$limit limit}) {
    var $arrayStartIndex = 1;
    final generatedpredicate = $write(
        predicate?.call(alias(this.accounts, 'a'),
                alias(this.currencies, 'currency')) ??
            const CustomExpression('(TRUE)'),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    final generatedorderBy = $write(
        orderBy?.call(alias(this.accounts, 'a'),
                alias(this.currencies, 'currency')) ??
            const OrderBy.nothing(),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedorderBy.amountOfVariables;
    final generatedlimit = $write(
        limit(alias(this.accounts, 'a'), alias(this.currencies, 'currency')),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedlimit.amountOfVariables;
    return customSelect(
        'SELECT a.*,"currency"."code" AS "nested_0.code", "currency"."symbol" AS "nested_0.symbol" FROM accounts AS a INNER JOIN currencies AS currency ON a.currencyId = currency.code WHERE ${generatedpredicate.sql} ${generatedorderBy.sql} ${generatedlimit.sql}',
        variables: [
          ...generatedpredicate.introducedVariables,
          ...generatedorderBy.introducedVariables,
          ...generatedlimit.introducedVariables
        ],
        readsFrom: {
          accounts,
          currencies,
          ...generatedpredicate.watchedTables,
          ...generatedorderBy.watchedTables,
          ...generatedlimit.watchedTables,
        }).asyncMap((QueryRow row) async => Account(
          id: row.read<String>('id'),
          name: row.read<String>('name'),
          iniValue: row.read<double>('iniValue'),
          date: row.read<DateTime>('date'),
          type: Accounts.$convertertype.fromSql(row.read<String>('type')),
          iconId: row.read<String>('iconId'),
          currency: await currencies.mapFromRow(row, tablePrefix: 'nested_0'),
          closingDate: row.readNullable<DateTime>('closingDate'),
          description: row.readNullable<String>('description'),
          iban: row.readNullable<String>('iban'),
          swift: row.readNullable<String>('swift'),
        ));
  }

  Selectable<MoneyTransaction> getTransactionsWithFullData(
      {GetTransactionsWithFullData$predicate? predicate,
      GetTransactionsWithFullData$orderBy? orderBy,
      required GetTransactionsWithFullData$limit limit}) {
    var $arrayStartIndex = 1;
    final generatedpredicate = $write(
        predicate?.call(
                alias(this.transactions, 't'),
                alias(this.accounts, 'a'),
                alias(this.currencies, 'accountCurrency'),
                alias(this.accounts, 'ra'),
                alias(this.currencies, 'receivingAccountCurrency'),
                alias(this.categories, 'c'),
                alias(this.categories, 'pc')) ??
            const CustomExpression('(TRUE)'),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    final generatedorderBy = $write(
        orderBy?.call(
                alias(this.transactions, 't'),
                alias(this.accounts, 'a'),
                alias(this.currencies, 'accountCurrency'),
                alias(this.accounts, 'ra'),
                alias(this.currencies, 'receivingAccountCurrency'),
                alias(this.categories, 'c'),
                alias(this.categories, 'pc')) ??
            const OrderBy.nothing(),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedorderBy.amountOfVariables;
    final generatedlimit = $write(
        limit(
            alias(this.transactions, 't'),
            alias(this.accounts, 'a'),
            alias(this.currencies, 'accountCurrency'),
            alias(this.accounts, 'ra'),
            alias(this.currencies, 'receivingAccountCurrency'),
            alias(this.categories, 'c'),
            alias(this.categories, 'pc')),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedlimit.amountOfVariables;
    return customSelect(
        'SELECT t.*,"a"."id" AS "nested_0.id", "a"."name" AS "nested_0.name", "a"."iniValue" AS "nested_0.iniValue", "a"."date" AS "nested_0.date", "a"."description" AS "nested_0.description", "a"."type" AS "nested_0.type", "a"."iconId" AS "nested_0.iconId", "a"."color" AS "nested_0.color", "a"."closingDate" AS "nested_0.closingDate", "a"."currencyId" AS "nested_0.currencyId", "a"."iban" AS "nested_0.iban", "a"."swift" AS "nested_0.swift","accountCurrency"."code" AS "nested_1.code", "accountCurrency"."symbol" AS "nested_1.symbol","receivingAccountCurrency"."code" AS "nested_2.code", "receivingAccountCurrency"."symbol" AS "nested_2.symbol","ra"."id" AS "nested_3.id", "ra"."name" AS "nested_3.name", "ra"."iniValue" AS "nested_3.iniValue", "ra"."date" AS "nested_3.date", "ra"."description" AS "nested_3.description", "ra"."type" AS "nested_3.type", "ra"."iconId" AS "nested_3.iconId", "ra"."color" AS "nested_3.color", "ra"."closingDate" AS "nested_3.closingDate", "ra"."currencyId" AS "nested_3.currencyId", "ra"."iban" AS "nested_3.iban", "ra"."swift" AS "nested_3.swift","c"."id" AS "nested_4.id", "c"."name" AS "nested_4.name", "c"."iconId" AS "nested_4.iconId", "c"."color" AS "nested_4.color", "c"."type" AS "nested_4.type", "c"."parentCategoryID" AS "nested_4.parentCategoryID","pc"."id" AS "nested_5.id", "pc"."name" AS "nested_5.name", "pc"."iconId" AS "nested_5.iconId", "pc"."color" AS "nested_5.color", "pc"."type" AS "nested_5.type", "pc"."parentCategoryID" AS "nested_5.parentCategoryID", t.value * COALESCE(excRate.exchangeRate, 1) AS currentValueInPreferredCurrency, t.valueInDestiny * COALESCE(excRateOfDestiny.exchangeRate, 1) AS currentValueInDestinyInPreferredCurrency, t.id AS "\$n_0" FROM transactions AS t INNER JOIN accounts AS a ON t.accountID = a.id INNER JOIN currencies AS accountCurrency ON a.currencyId = accountCurrency.code LEFT JOIN accounts AS ra ON t.receivingAccountID = ra.id INNER JOIN currencies AS receivingAccountCurrency ON a.currencyId = receivingAccountCurrency.code LEFT JOIN categories AS c ON t.categoryID = c.id LEFT JOIN categories AS pc ON c.parentCategoryID = pc.id LEFT JOIN (SELECT currencyCode, exchangeRate FROM exchangeRates AS er WHERE date = (SELECT MAX(date) FROM exchangeRates WHERE currencyCode = er.currencyCode AND DATE <= DATE(\'now\')) ORDER BY currencyCode) AS excRate ON a.currencyId = excRate.currencyCode LEFT JOIN (SELECT currencyCode, exchangeRate FROM exchangeRates AS er WHERE date = (SELECT MAX(date) FROM exchangeRates WHERE currencyCode = er.currencyCode AND DATE <= DATE(\'now\')) ORDER BY currencyCode) AS excRateOfDestiny ON ra.currencyId = excRateOfDestiny.currencyCode WHERE ${generatedpredicate.sql} ${generatedorderBy.sql} ${generatedlimit.sql}',
        variables: [
          ...generatedpredicate.introducedVariables,
          ...generatedorderBy.introducedVariables,
          ...generatedlimit.introducedVariables
        ],
        readsFrom: {
          transactionTags,
          tags,
          transactions,
          accounts,
          currencies,
          categories,
          exchangeRates,
          ...generatedpredicate.watchedTables,
          ...generatedorderBy.watchedTables,
          ...generatedlimit.watchedTables,
        }).asyncMap((QueryRow row) async => MoneyTransaction(
          id: row.read<String>('id'),
          date: row.read<DateTime>('date'),
          value: row.read<double>('value'),
          isHidden: row.read<bool>('isHidden'),
          notes: row.readNullable<String>('notes'),
          title: row.readNullable<String>('title'),
          status: NullAwareTypeConverter.wrapFromSql(
              Transactions.$converterstatus,
              row.readNullable<String>('status')),
          valueInDestiny: row.readNullable<double>('valueInDestiny'),
          account: await accounts.mapFromRow(row, tablePrefix: 'nested_0'),
          receivingAccount:
              await accounts.mapFromRowOrNull(row, tablePrefix: 'nested_3'),
          accountCurrency:
              await currencies.mapFromRow(row, tablePrefix: 'nested_1'),
          receivingAccountCurrency:
              await currencies.mapFromRow(row, tablePrefix: 'nested_2'),
          category:
              await categories.mapFromRowOrNull(row, tablePrefix: 'nested_4'),
          parentCategory:
              await categories.mapFromRowOrNull(row, tablePrefix: 'nested_5'),
          currentValueInDestinyInPreferredCurrency: row
              .readNullable<double>('currentValueInDestinyInPreferredCurrency'),
          currentValueInPreferredCurrency:
              row.read<double>('currentValueInPreferredCurrency'),
          tags: await customSelect(
              'SELECT tags.* FROM transactionTags INNER JOIN tags ON transactionTags.tagID = tags.id WHERE transactionTags.transactionID = ?1',
              variables: [
                Variable<String>(row.read('\$n_0'))
              ],
              readsFrom: {
                transactionTags,
                tags,
                transactions,
              }).asyncMap(tags.mapFromRow).get(),
          endDate: row.readNullable<DateTime>('endDate'),
          intervalEach: row.readNullable<int>('intervalEach'),
          intervalPeriod: NullAwareTypeConverter.wrapFromSql(
              Transactions.$converterintervalPeriod,
              row.readNullable<String>('intervalPeriod')),
          remainingTransactions: row.readNullable<int>('remainingTransactions'),
        ));
  }

  Selectable<CountTransactionsResult> countTransactions(
      {required DateTime date, CountTransactions$predicate? predicate}) {
    var $arrayStartIndex = 2;
    final generatedpredicate = $write(
        predicate?.call(
                alias(this.transactions, 't'),
                alias(this.accounts, 'a'),
                alias(this.currencies, 'accountCurrency'),
                alias(this.accounts, 'ra'),
                alias(this.currencies, 'receivingAccountCurrency'),
                alias(this.categories, 'c'),
                alias(this.categories, 'pc')) ??
            const CustomExpression('(TRUE)'),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    return customSelect(
        'SELECT COUNT(*) AS transactionsNumber, COALESCE(SUM(t.value), 0) AS sum, COALESCE(SUM(COALESCE(t.valueInDestiny, t.value)), 0) AS sumInDestiny, COALESCE(SUM(t.value * COALESCE(excRate.exchangeRate, 1)), 0) AS sumInPrefCurrency, COALESCE(SUM(COALESCE(t.valueInDestiny, t.value) * COALESCE(excRateOfDestiny.exchangeRate, 1)), 0) AS sumInDestinyInPrefCurrency FROM transactions AS t INNER JOIN accounts AS a ON t.accountID = a.id INNER JOIN currencies AS accountCurrency ON a.currencyId = accountCurrency.code LEFT JOIN accounts AS ra ON t.receivingAccountID = ra.id INNER JOIN currencies AS receivingAccountCurrency ON a.currencyId = receivingAccountCurrency.code LEFT JOIN categories AS c ON t.categoryID = c.id LEFT JOIN categories AS pc ON c.parentCategoryID = pc.id LEFT JOIN (SELECT currencyCode, exchangeRate FROM exchangeRates AS er WHERE date = (SELECT MAX(date) FROM exchangeRates WHERE currencyCode = er.currencyCode AND DATE <= ?1) ORDER BY currencyCode) AS excRate ON a.currencyId = excRate.currencyCode LEFT JOIN (SELECT currencyCode, exchangeRate FROM exchangeRates AS er WHERE date = (SELECT MAX(date) FROM exchangeRates WHERE currencyCode = er.currencyCode AND DATE <= ?1) ORDER BY currencyCode) AS excRateOfDestiny ON ra.currencyId = excRateOfDestiny.currencyCode WHERE ${generatedpredicate.sql}',
        variables: [
          Variable<DateTime>(date),
          ...generatedpredicate.introducedVariables
        ],
        readsFrom: {
          transactions,
          accounts,
          currencies,
          categories,
          exchangeRates,
          ...generatedpredicate.watchedTables,
        }).map((QueryRow row) => CountTransactionsResult(
          transactionsNumber: row.read<int>('transactionsNumber'),
          sum: row.read<double>('sum'),
          sumInDestiny: row.read<double>('sumInDestiny'),
          sumInPrefCurrency: row.read<double>('sumInPrefCurrency'),
          sumInDestinyInPrefCurrency:
              row.read<double>('sumInDestinyInPrefCurrency'),
        ));
  }

  Selectable<Category> getCategoriesWithFullData(
      {GetCategoriesWithFullData$predicate? predicate, required double limit}) {
    var $arrayStartIndex = 2;
    final generatedpredicate = $write(
        predicate?.call(alias(this.categories, 'a'),
                alias(this.categories, 'parentCategory')) ??
            const CustomExpression('(TRUE)'),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    return customSelect(
        'SELECT a.*,"parentCategory"."id" AS "nested_0.id", "parentCategory"."name" AS "nested_0.name", "parentCategory"."iconId" AS "nested_0.iconId", "parentCategory"."color" AS "nested_0.color", "parentCategory"."type" AS "nested_0.type", "parentCategory"."parentCategoryID" AS "nested_0.parentCategoryID" FROM categories AS a LEFT JOIN categories AS parentCategory ON a.parentCategoryID = parentCategory.id WHERE ${generatedpredicate.sql} LIMIT ?1',
        variables: [
          Variable<double>(limit),
          ...generatedpredicate.introducedVariables
        ],
        readsFrom: {
          categories,
          ...generatedpredicate.watchedTables,
        }).asyncMap((QueryRow row) async => Category(
          id: row.read<String>('id'),
          name: row.read<String>('name'),
          iconId: row.read<String>('iconId'),
          color: row.readNullable<String>('color'),
          type: NullAwareTypeConverter.wrapFromSql(
              Categories.$convertertype, row.readNullable<String>('type')),
          parentCategory:
              await categories.mapFromRowOrNull(row, tablePrefix: 'nested_0'),
        ));
  }

  Selectable<ExchangeRate> getExchangeRates(
      {GetExchangeRates$predicate? predicate, required double limit}) {
    var $arrayStartIndex = 2;
    final generatedpredicate = $write(
        predicate?.call(alias(this.exchangeRates, 'e'),
                alias(this.currencies, 'currency')) ??
            const CustomExpression('(TRUE)'),
        hasMultipleTables: true,
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    return customSelect(
        'SELECT e.*,"currency"."code" AS "nested_0.code", "currency"."symbol" AS "nested_0.symbol" FROM exchangeRates AS e INNER JOIN currencies AS currency ON e.currencyCode = currency.code WHERE ${generatedpredicate.sql} ORDER BY date DESC LIMIT ?1',
        variables: [
          Variable<double>(limit),
          ...generatedpredicate.introducedVariables
        ],
        readsFrom: {
          exchangeRates,
          currencies,
          ...generatedpredicate.watchedTables,
        }).asyncMap((QueryRow row) async => ExchangeRate(
          id: row.read<String>('id'),
          date: row.read<DateTime>('date'),
          currency: await currencies.mapFromRow(row, tablePrefix: 'nested_0'),
          exchangeRate: row.read<double>('exchangeRate'),
        ));
  }

  Selectable<ExchangeRate> getLastExchangeRates({required double limit}) {
    return customSelect(
        'SELECT er.*,"currency"."code" AS "nested_0.code", "currency"."symbol" AS "nested_0.symbol" FROM exchangeRates AS er INNER JOIN currencies AS currency ON er.currencyCode = currency.code WHERE date = (SELECT MAX(date) FROM exchangeRates WHERE currencyCode = er.currencyCode) ORDER BY currency.code LIMIT ?1',
        variables: [
          Variable<double>(limit)
        ],
        readsFrom: {
          exchangeRates,
          currencies,
        }).asyncMap((QueryRow row) async => ExchangeRate(
          id: row.read<String>('id'),
          date: row.read<DateTime>('date'),
          currency: await currencies.mapFromRow(row, tablePrefix: 'nested_0'),
          exchangeRate: row.read<double>('exchangeRate'),
        ));
  }

  Selectable<Budget> getBudgetsWithFullData(
      {GetBudgetsWithFullData$predicate? predicate,
      GetBudgetsWithFullData$orderBy? orderBy,
      required GetBudgetsWithFullData$limit limit}) {
    var $arrayStartIndex = 1;
    final generatedpredicate = $write(
        predicate?.call(this.budgets) ?? const CustomExpression('(TRUE)'),
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedpredicate.amountOfVariables;
    final generatedorderBy = $write(
        orderBy?.call(this.budgets) ?? const OrderBy.nothing(),
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedorderBy.amountOfVariables;
    final generatedlimit =
        $write(limit(this.budgets), startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedlimit.amountOfVariables;
    return customSelect(
        'SELECT id, name, limitAmount, intervalPeriod, startDate, endDate, budgets.id AS "\$n_0", budgets.id AS "\$n_1" FROM budgets WHERE ${generatedpredicate.sql} ${generatedorderBy.sql} ${generatedlimit.sql}',
        variables: [
          ...generatedpredicate.introducedVariables,
          ...generatedorderBy.introducedVariables,
          ...generatedlimit.introducedVariables
        ],
        readsFrom: {
          budgets,
          budgetCategory,
          budgetAccount,
          ...generatedpredicate.watchedTables,
          ...generatedorderBy.watchedTables,
          ...generatedlimit.watchedTables,
        }).asyncMap((QueryRow row) async => Budget(
          id: row.read<String>('id'),
          name: row.read<String>('name'),
          limitAmount: row.read<double>('limitAmount'),
          categories: await customSelect(
              'SELECT categoryID FROM budgetCategory WHERE budgetID = ?1',
              variables: [
                Variable<String>(row.read('\$n_0'))
              ],
              readsFrom: {
                budgetCategory,
                budgets,
              }).map((QueryRow row) => row.read<String>('categoryID')).get(),
          accounts: await customSelect(
              'SELECT accountID FROM budgetAccount WHERE budgetID = ?1',
              variables: [
                Variable<String>(row.read('\$n_1'))
              ],
              readsFrom: {
                budgetAccount,
                budgets,
              }).map((QueryRow row) => row.read<String>('accountID')).get(),
          intervalPeriod: NullAwareTypeConverter.wrapFromSql(
              Budgets.$converterintervalPeriod,
              row.readNullable<String>('intervalPeriod')),
          startDate: row.readNullable<DateTime>('startDate'),
          endDate: row.readNullable<DateTime>('endDate'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        currencies,
        accounts,
        categories,
        transactions,
        exchangeRates,
        tags,
        transactionTags,
        budgets,
        budgetCategory,
        budgetAccount,
        currencyNames,
        userSettings,
        appData
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('accounts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('accounts', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('transactions', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('transactions', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('transactions', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('exchangeRates', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('exchangeRates', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('transactions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactionTags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('transactions',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('transactionTags', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('transactionTags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('tags',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('transactionTags', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budgetCategory', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('budgetCategory', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budgetCategory', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('budgetCategory', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budgetAccount', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('budgets',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('budgetAccount', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('budgetAccount', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('budgetAccount', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('currencyNames', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('currencies',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('currencyNames', kind: UpdateKind.update),
            ],
          ),
        ],
      );
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef GetAccountsWithFullData$predicate = Expression<bool> Function(
    Accounts a, Currencies currency);
typedef GetAccountsWithFullData$orderBy = OrderBy Function(
    Accounts a, Currencies currency);
typedef GetAccountsWithFullData$limit = Limit Function(
    Accounts a, Currencies currency);
typedef GetTransactionsWithFullData$predicate = Expression<bool> Function(
    Transactions t,
    Accounts a,
    Currencies accountCurrency,
    Accounts ra,
    Currencies receivingAccountCurrency,
    Categories c,
    Categories pc);
typedef GetTransactionsWithFullData$orderBy = OrderBy Function(
    Transactions t,
    Accounts a,
    Currencies accountCurrency,
    Accounts ra,
    Currencies receivingAccountCurrency,
    Categories c,
    Categories pc);
typedef GetTransactionsWithFullData$limit = Limit Function(
    Transactions t,
    Accounts a,
    Currencies accountCurrency,
    Accounts ra,
    Currencies receivingAccountCurrency,
    Categories c,
    Categories pc);

class CountTransactionsResult {
  final int transactionsNumber;
  final double sum;
  final double sumInDestiny;
  final double sumInPrefCurrency;
  final double sumInDestinyInPrefCurrency;
  CountTransactionsResult({
    required this.transactionsNumber,
    required this.sum,
    required this.sumInDestiny,
    required this.sumInPrefCurrency,
    required this.sumInDestinyInPrefCurrency,
  });
}

typedef CountTransactions$predicate = Expression<bool> Function(
    Transactions t,
    Accounts a,
    Currencies accountCurrency,
    Accounts ra,
    Currencies receivingAccountCurrency,
    Categories c,
    Categories pc);
typedef GetCategoriesWithFullData$predicate = Expression<bool> Function(
    Categories a, Categories parentCategory);
typedef GetExchangeRates$predicate = Expression<bool> Function(
    ExchangeRates e, Currencies currency);
typedef GetBudgetsWithFullData$predicate = Expression<bool> Function(
    Budgets budgets);
typedef GetBudgetsWithFullData$orderBy = OrderBy Function(Budgets budgets);
typedef GetBudgetsWithFullData$limit = Limit Function(Budgets budgets);
