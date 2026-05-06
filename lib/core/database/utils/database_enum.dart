abstract interface class DatabaseEnum<V> implements Enum {
  /// Getter to obtain the value to be stored in the database
  V get databaseValue;
}
