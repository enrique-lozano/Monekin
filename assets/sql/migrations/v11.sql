-- ============================================================
-- v11 Migration: Investment accounts, assets, and valuations
-- ============================================================

-- Step 1: Disable foreign key enforcement during table rebuild
PRAGMA foreign_keys = OFF;

-- Step 2: Recreate the accounts table to:
--   • Allow the new 'investment' account type
CREATE TABLE accounts_new (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    iniValue REAL NOT NULL,
    date TEXT NOT NULL,
    description TEXT,
    type TEXT NOT NULL CHECK(type IN ('normal', 'saving', 'investment')),
    iconId TEXT NOT NULL,
    displayOrder INTEGER NOT NULL,
    color TEXT,
    closingDate TEXT,
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    iban TEXT,
    swift TEXT
);

-- Step 3: Copy existing accounts
INSERT INTO accounts_new
    SELECT id, name, iniValue, date, description, type, iconId, displayOrder,
           color, closingDate, currencyId, iban, swift, 1
    FROM accounts;

-- Step 4: Drop the old table and rename
DROP TABLE accounts;
ALTER TABLE accounts_new RENAME TO accounts;

-- Step 5: Re-enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- ---------------------------------------------------------------
-- New table: assets
-- Represents non-liquid wealth (real estate, vehicles, etc.)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS assets (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    initialValue REAL NOT NULL DEFAULT 0,
    creationDate TEXT NOT NULL
);

-- ---------------------------------------------------------------
-- New table: valuations
-- Historical value snapshots for investment accounts or assets.
-- Exactly one of accountId / assetId must be set.
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS valuations (
    id TEXT NOT NULL PRIMARY KEY,
    accountId TEXT REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    assetId TEXT REFERENCES assets(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date TEXT NOT NULL,
    value REAL NOT NULL,
    CHECK ((accountId IS NULL) != (assetId IS NULL))
);
