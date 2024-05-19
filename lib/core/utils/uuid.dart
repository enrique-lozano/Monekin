import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Generate a `v4` UUID, useful for most of the items that will be saved to the DB
String generateUUID() => _uuid.v4();
