# Database migrations

Each file here holds the SQL to move the database **from the previous version to the one named in the file**. Files are named `v2.sql`, `v3.sql`, … where the number is the **target** version.

When the app opens a database whose stored version is lower than `AppDB.schemaVersion`, the runner (`migrateDB` in `lib/core/database/app_db.dart`) applies each missing `vN.sql` in order.

## How a migration file is executed

1. The file is read and split into individual statements by `splitSQLStatements`, which simply splits on `;` followed by whitespace.
2. Every `PRAGMA foreign_keys ...` statement is **removed** from the file.
3. FK enforcement is turned **OFF**, then all statements run inside a single **transaction**. After them, a `PRAGMA foreign_key_check` runs; if it finds violations (or any statement fails) the whole version is **rolled back** and the DB stays at the last good version. FK enforcement is turned back **ON** afterwards. A `*.pre_migration_vN.db` backup is kept until it succeeds.

Because the version bump happens in that same transaction, version and schema never drift apart.

## Rules & best practices (learned the hard way)

- **Never write `PRAGMA foreign_keys` in a migration file.** It is stripped and ignored — the runner already toggles FK enforcement around the transaction. (Also, `PRAGMA foreign_keys` is a silent no-op inside a transaction anyway.)
- **Never put a `;` inside a comment or a string literal.** The splitter breaks on _every_ `;`, so a `;` in a `-- comment` cuts a statement in half and you get errors like `near "...": syntax error`. Reword the comment (e.g. use `,` or parentheses) or the literal.
- **Do not** change the `dbVersion` row of the `appData` table by hand — it is updated automatically when a migration succeeds.
- **Rebuilding a table that other tables reference?** Don't rename the original out of the way (`ALTER TABLE t RENAME TO t_old`): modern SQLite rewrites the child tables' foreign keys to point at `t_old`. Instead:
  1. `CREATE TABLE t_new (...)`,
  2. `INSERT INTO t_new SELECT ... FROM t`,
  3. `DROP TABLE t`,
  4. `ALTER TABLE t_new RENAME TO t`.
     Child FKs keep referencing `t`, so they stay valid. (See the `accounts` and `assets` rebuilds in `v13.sql`.) This relies on FK enforcement being OFF, which the runner guarantees.
- Statements run in file order, so create referenced tables before the tables / rows that point at them, and do data conversions before dropping the source.
- Keep each version **idempotent-friendly and atomic**: assume it runs as one all-or-nothing transaction.
