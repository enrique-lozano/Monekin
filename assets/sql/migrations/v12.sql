-- ============================================================
-- v12 Migration: Investment transactions, linked portfolio
-- assets, and moving legacy account valuations to assets
-- ============================================================

-- Step 1: Disable foreign key enforcement during schema changes
PRAGMA foreign_keys = OFF;

-- Step 2: Extend `assets` for typed holdings and optional link to
--         an investment account (portfolio rolls into that account)
ALTER TABLE assets ADD COLUMN assetType TEXT NOT NULL DEFAULT 'other';
ALTER TABLE assets ADD COLUMN linkedAccountID TEXT REFERENCES accounts(id) ON DELETE SET NULL ON UPDATE CASCADE;

-- Step 3: Recreate `transactions` (add investment type + assetID)
ALTER TABLE transactions RENAME TO transactions_old;

CREATE TABLE transactions (
  id TEXT NOT NULL PRIMARY KEY,
  date TEXT NOT NULL,
  accountID TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  value REAL NOT NULL,
  title TEXT,
  notes TEXT,
  type TEXT NOT NULL CHECK(type IN ('E', 'I', 'T', 'N')),
  status TEXT CHECK(status IN ('V', 'P', 'R', 'U')),
  categoryID TEXT REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE,
  debtId TEXT REFERENCES debts(id) ON DELETE SET NULL ON UPDATE CASCADE,
  receivingAccountID TEXT REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  valueInDestiny REAL,
  isHidden INTEGER NOT NULL DEFAULT 0,
  locLatitude REAL,
  locLongitude REAL,
  locAddress TEXT,
  intervalPeriod TEXT CHECK(intervalPeriod IN ('day','week','month','year')),
  intervalEach INTEGER,
  endDate TEXT,
  remainingTransactions INTEGER,
  assetID TEXT REFERENCES assets(id) ON DELETE SET NULL ON UPDATE CASCADE,
  CHECK (
    (type = 'N' AND assetID IS NOT NULL AND receivingAccountID IS NULL AND categoryID IS NULL AND valueInDestiny IS NULL)
    OR
    (type != 'N' AND ((receivingAccountID IS NULL) != (categoryID IS NULL)))
  ),
  CHECK ((intervalPeriod IS NULL) == (intervalEach IS NULL)),
  CHECK ((intervalPeriod IS NOT NULL) OR (endDate IS NULL)),
  CHECK ((intervalPeriod IS NOT NULL) OR (remainingTransactions IS NULL)),
  CHECK ((locLongitude IS NULL AND locLatitude IS NULL) OR (locLongitude IS NOT NULL AND locLatitude IS NOT NULL)),
  CHECK ((locAddress IS NULL) OR (locLatitude IS NOT NULL AND locLongitude IS NOT NULL)),
  CHECK (categoryID IS NULL OR valueInDestiny IS NULL)
);

-- Step 4: Copy all existing transactions, using NULL for the new `assetID`
INSERT INTO transactions
SELECT id, date, accountID, value, title, notes, type, status, categoryID, debtId, receivingAccountID, valueInDestiny, isHidden, locLatitude, locLongitude, locAddress, intervalPeriod, intervalEach, endDate, remainingTransactions, NULL
FROM transactions_old;

DROP TABLE transactions_old;

-- Step 5: One linked “funds” asset per investment account that
--         already had account-level valuation history (so charts
--         and balances can use asset valuations consistently).
INSERT INTO assets (id, name, description, currencyId, initialValue, creationDate, assetType, linkedAccountID)
SELECT lower(hex(randomblob(16))), a.name || ' Portfolio', NULL, a.currencyId, 0, a.date, 'funds', a.id
FROM accounts a
WHERE a.type = 'investment'
AND EXISTS (SELECT 1 FROM valuations v WHERE v.accountId = a.id AND v.assetId IS NULL);

-- Step 6: Copy legacy investment account valuations onto the new
--         linked portfolio asset (accountId cleared on the copy).
INSERT INTO valuations (id, accountId, assetId, date, value)
SELECT lower(hex(randomblob(16))), NULL, (
  SELECT ast.id FROM assets ast WHERE ast.linkedAccountID = a.id AND ast.assetType = 'funds' LIMIT 1
), v.date, v.value
FROM valuations v
INNER JOIN accounts a ON a.id = v.accountId AND a.type = 'investment'
WHERE v.accountId IS NOT NULL AND v.assetId IS NULL
AND EXISTS (SELECT 1 FROM assets ast2 WHERE ast2.linkedAccountID = a.id AND ast2.assetType = 'funds');

-- Step 7: Remove old account-only rows for investment accounts.
--         Non-investment account valuations are unchanged.
DELETE FROM valuations
WHERE accountId IS NOT NULL
  AND assetId IS NULL
  AND accountId IN (SELECT id FROM accounts WHERE type = 'investment');

-- Step 8: Re-enable foreign key enforcement
PRAGMA foreign_keys = ON;
