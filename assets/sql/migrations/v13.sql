-- ============================================================
-- v13 Migration: Accounts/Holdings/Assets/Securities redesign
--   * Account types collapse to `money` | `investment` + a new
--     `isSaving` flag (the old `saving` type becomes money+flag).
--   * Investment accounts gain a `trackingMode` ('transactions' or
--     'holdings'), assigned heuristically below.
--   * New `securities` + `holdings` tables (financial instruments
--     held inside investment accounts, weighted-average cost).
--   * New `securityPriceHistory` table (manual price observations
--     over time, powering the real price chart).
--   * New `accountSnapshots` + `holdingSnapshots` tables (manual
--     portfolio-snapshot history for accounts tracked in 'holdings'
--     mode: a snapshot is the full portfolio photo for a date).
--   * `assets` gains an optional `linkedDebtId` (e.g. a mortgage)
--     and is restricted to PHYSICAL types only.
--   * `transactions` (type 'N') can now reference a security with
--     quantity/pricePerUnit, not only an asset.
--   * New `taxonomies` + `taxonomyCategories` + `securityTaxonomyAssignments`
--     tables (user-editable classification of securities by asset
--     class / region / sector / risk for portfolio composition). The
--     built-in taxonomies are seeded in Dart (TaxonomyService), so the
--     tables are only CREATEd here.
--
-- TRACKING MODE HEURISTIC: an investment account that already had
-- real investment transactions (type 'N') is tracked in
-- 'transactions' mode (positions derived from trades). Otherwise it
-- is tracked in 'holdings' mode (positions kept as manual snapshots).
--
-- ASSET SPLIT: assets are now physical/non-market only. Existing
-- financial assets (stocks/funds/crypto) are auto-converted into
-- `securities` here:
--   - one security per financial asset (latest valuation as price),
--   - its valuations become `securityPriceHistory` points,
--   - if it was linked to an account, a `holding` of quantity 1 is
--     created (avg cost = the security's current price, so the
--     migrated position shows no phantom gain/loss). For accounts in
--     'transactions' mode its cash trades are repointed to the new
--     security (one anchor trade carries the single unit). For
--     accounts in 'holdings' mode a position snapshot is seeded
--     instead and no trades are created,
--   - the original financial asset is then deleted.
-- Unlinked financial assets become securities without a holding.
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Rebuild `accounts` with the new type enum + isSaving.
-- We create a new table and swap it in (instead of renaming the
-- original to *_old) so that foreign keys in child tables keep
-- pointing at `accounts`.
-- ------------------------------------------------------------
CREATE TABLE accounts_new (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    iniValue REAL NOT NULL,
    date TEXT NOT NULL,
    description TEXT,
    type TEXT NOT NULL CHECK(type IN ('money', 'investment')),
    isSaving INTEGER NOT NULL DEFAULT 0,
    trackingMode TEXT NOT NULL DEFAULT 'transactions' CHECK(trackingMode IN ('transactions', 'holdings')),
    iconId TEXT NOT NULL,
    displayOrder INTEGER NOT NULL,
    color TEXT,
    closingDate TEXT,
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    iban TEXT,
    swift TEXT
);

-- normal -> money, saving -> money (+isSaving), investment -> investment.
-- trackingMode heuristic: only investment accounts can be tracked via
-- snapshots, and only when they had no type 'N' investment transactions to
-- derive their positions from. Everything else keeps the default 'transactions'
-- (the mode is meaningless for money accounts, so leaving them on the default
-- avoids a stale value nobody would ever notice or fix).
INSERT INTO accounts_new (id, name, iniValue, date, description, type, isSaving, trackingMode, iconId, displayOrder, color, closingDate, currencyId, iban, swift)
SELECT
    id,
    name,
    iniValue,
    date,
    description,
    CASE type WHEN 'investment' THEN 'investment' ELSE 'money' END,
    CASE type WHEN 'saving' THEN 1 ELSE 0 END,
    CASE
        WHEN type != 'investment' THEN 'transactions'
        WHEN EXISTS (SELECT 1 FROM transactions t WHERE t.accountID = accounts.id AND t.type = 'N')
        THEN 'transactions'
        ELSE 'holdings'
    END,
    iconId,
    displayOrder,
    color,
    closingDate,
    currencyId,
    iban,
    swift
FROM accounts;

DROP TABLE accounts;

ALTER TABLE accounts_new RENAME TO accounts;

-- ------------------------------------------------------------
-- Step 2: New `securities` table (shared financial instruments).
-- ------------------------------------------------------------
CREATE TABLE securities (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT 'stock' CHECK(type IN ('stock', 'fund', 'crypto')),
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    ticker TEXT,
    notes TEXT,
    currentPrice REAL,
    priceDate TEXT,
    iconId TEXT,
    color TEXT
);

-- Manual price observations for a security over time (real price chart).
CREATE TABLE securityPriceHistory (
    id TEXT NOT NULL PRIMARY KEY,
    securityID TEXT NOT NULL REFERENCES securities(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date TEXT NOT NULL,
    price REAL NOT NULL
);

-- ------------------------------------------------------------
-- Step 3: New `holdings` table (a security position in an account).
-- ------------------------------------------------------------
CREATE TABLE holdings (
    id TEXT NOT NULL PRIMARY KEY,
    accountID TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    securityID TEXT NOT NULL REFERENCES securities(id) ON DELETE CASCADE ON UPDATE CASCADE,
    quantity REAL NOT NULL DEFAULT 0,
    avgCostPrice REAL NOT NULL DEFAULT 0,
    UNIQUE(accountID, securityID)
);

-- ------------------------------------------------------------
-- Step 4: New portfolio-snapshot tables (manual position history for
-- accounts in 'holdings' tracking mode). A snapshot (accountSnapshots)
-- is the full portfolio photo for a date. Its positions live in
-- holdingSnapshots. A snapshot with no positions = empty portfolio.
-- ------------------------------------------------------------
CREATE TABLE accountSnapshots (
    id TEXT NOT NULL PRIMARY KEY,
    accountID TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    date TEXT NOT NULL,
    UNIQUE(accountID, date)
);

CREATE TABLE holdingSnapshots (
    id TEXT NOT NULL PRIMARY KEY,
    snapshotID TEXT NOT NULL REFERENCES accountSnapshots(id) ON DELETE CASCADE ON UPDATE CASCADE,
    securityID TEXT NOT NULL REFERENCES securities(id) ON DELETE CASCADE ON UPDATE CASCADE,
    quantity REAL NOT NULL,
    avgCostPrice REAL NOT NULL,
    UNIQUE(snapshotID, securityID)
);

-- ------------------------------------------------------------
-- Step 5: (moved) The optional `linkedDebtId` column and the
-- physical-only type restriction are applied in the assets rebuild
-- at Step 8, after financial assets have been converted.
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Step 6: Rebuild `transactions` to add securityID/quantity/
-- pricePerUnit and relax the type='N' CHECK so an investment
-- transaction may reference EITHER an asset OR a security.
-- ------------------------------------------------------------
ALTER TABLE transactionTags RENAME TO transactionTags_old;
ALTER TABLE transactions RENAME TO transactions_old;

CREATE TABLE transactions (
  id TEXT NOT NULL PRIMARY KEY,
  date TEXT NOT NULL,
  accountID TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  value REAL NOT NULL,
  title TEXT,
  notes TEXT,
  type TEXT NOT NULL CHECK(type IN ('E', 'I', 'T', 'N')),
  assetID TEXT REFERENCES assets(id) ON DELETE SET NULL ON UPDATE CASCADE,
  securityID TEXT REFERENCES securities(id) ON DELETE SET NULL ON UPDATE CASCADE,
  quantity REAL,
  pricePerUnit REAL,
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
  CHECK (
    (type = 'N' AND (assetID IS NOT NULL OR securityID IS NOT NULL) AND receivingAccountID IS NULL AND categoryID IS NULL AND valueInDestiny IS NULL)
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

-- Copy existing transactions, defaulting the new security columns to NULL
INSERT INTO transactions (id, date, accountID, value, title, notes, type, assetID, securityID, quantity, pricePerUnit, status, categoryID, debtId, receivingAccountID, valueInDestiny, isHidden, locLatitude, locLongitude, locAddress, intervalPeriod, intervalEach, endDate, remainingTransactions)
SELECT id, date, accountID, value, title, notes, type, assetID, NULL, NULL, NULL, status, categoryID, debtId, receivingAccountID, valueInDestiny, isHidden, locLatitude, locLongitude, locAddress, intervalPeriod, intervalEach, endDate, remainingTransactions
FROM transactions_old;

-- Recreate `transactionTags` referencing the new `transactions` table
CREATE TABLE transactionTags (
  transactionID TEXT NOT NULL REFERENCES transactions(id) ON DELETE CASCADE ON UPDATE CASCADE,
  tagID TEXT NOT NULL REFERENCES tags(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO transactionTags (transactionID, tagID)
SELECT transactionID, tagID FROM transactionTags_old;

DROP TABLE transactionTags_old;

DROP TABLE transactions_old;

-- ------------------------------------------------------------
-- Step 7: Convert financial assets (stocks/funds/crypto) into
-- securities (+ price history, holdings and repointed trades).
-- ------------------------------------------------------------

-- 7a. One security per financial asset. Current price = latest
--     valuation, falling back to the asset's initial value.
INSERT INTO securities (id, name, type, currencyId, ticker, notes, currentPrice, priceDate, iconId, color)
SELECT
    'sec_' || a.id,
    a.name,
    CASE a.assetType
        WHEN 'stocks' THEN 'stock'
        WHEN 'funds' THEN 'fund'
        WHEN 'crypto' THEN 'crypto'
    END,
    a.currencyId,
    NULL,
    a.description,
    COALESCE(
        (SELECT v.value FROM valuations v WHERE v.assetId = a.id ORDER BY v.date DESC LIMIT 1),
        a.initialValue
    ),
    COALESCE(
        (SELECT v.date FROM valuations v WHERE v.assetId = a.id ORDER BY v.date DESC LIMIT 1),
        a.creationDate
    ),
    NULL,
    NULL
FROM assets a
WHERE a.assetType IN ('stocks', 'funds', 'crypto');

-- 7b. Valuations of those assets become price-history points.
INSERT INTO securityPriceHistory (id, securityID, date, price)
SELECT 'sph_' || v.id, 'sec_' || v.assetId, v.date, v.value
FROM valuations v
INNER JOIN assets a ON a.id = v.assetId
WHERE a.assetType IN ('stocks', 'funds', 'crypto');

-- 7b-bis. Financial assets without valuations get a single seed point.
INSERT INTO securityPriceHistory (id, securityID, date, price)
SELECT 'sphinit_' || a.id, 'sec_' || a.id, a.creationDate, a.initialValue
FROM assets a
WHERE a.assetType IN ('stocks', 'funds', 'crypto')
  AND NOT EXISTS (SELECT 1 FROM valuations v WHERE v.assetId = a.id);

-- 7c. Financial assets linked to an account become a holding of a
--     single unit. Migration carries no real cost basis, so the avg
--     cost is set to the security's current price (= latest valuation,
--     falling back to the initial value). This way the position shows
--     no phantom gain/loss right after migrating.
INSERT INTO holdings (id, accountID, securityID, quantity, avgCostPrice)
SELECT 'hold_' || a.id, a.linkedAccountID, 'sec_' || a.id, 1,
       COALESCE(s.currentPrice, a.initialValue)
FROM assets a
JOIN securities s ON s.id = 'sec_' || a.id
WHERE a.assetType IN ('stocks', 'funds', 'crypto')
  AND a.linkedAccountID IS NOT NULL;

-- 7c-bis. Holdings-mode accounts keep positions as portfolio snapshots
--         instead of trades. Seed ONE snapshot per holdings-mode account
--         that holds securities (dated at the account's latest security
--         price date), containing all of its migrated holdings, so the
--         snapshot is a complete portfolio photo.
INSERT INTO accountSnapshots (id, accountID, date)
SELECT 'asnap_' || a.id, a.id,
       COALESCE(
         (SELECT MAX(s.priceDate) FROM holdings h
            JOIN securities s ON s.id = h.securityID
            WHERE h.accountID = a.id),
         DATE('now')
       )
FROM accounts a
WHERE a.trackingMode = 'holdings'
  AND EXISTS (SELECT 1 FROM holdings h WHERE h.accountID = a.id);

INSERT INTO holdingSnapshots (id, snapshotID, securityID, quantity, avgCostPrice)
SELECT 'hpos_' || h.id, 'asnap_' || h.accountID, h.securityID, h.quantity, h.avgCostPrice
FROM holdings h
JOIN accounts a ON a.id = h.accountID
WHERE a.trackingMode = 'holdings';

-- 7d. Repoint the cash trades of those assets to the new security.
--     Units start at 0 (an anchor trade in 7e carries the single unit).
--     Only transactions-mode accounts have type 'N' trades, so holdings-mode
--     accounts are naturally untouched here.
UPDATE transactions
SET securityID = 'sec_' || assetID,
    assetID = NULL,
    quantity = 0,
    pricePerUnit = NULL
WHERE type = 'N'
  AND assetID IN (SELECT id FROM assets WHERE assetType IN ('stocks', 'funds', 'crypto'));

-- 7e. Anchor trade: the earliest repointed trade per security carries the
--     single unit at the security's current price (same value used for the
--     holding's avg cost in 7c), so replaying the trades reproduces the
--     holding (quantity 1) without introducing a phantom gain/loss. Pre-v13
--     there are no other security trades, so any type 'N' row with a
--     securityID was created here.
UPDATE transactions
SET quantity = 1,
    pricePerUnit = COALESCE(
        (SELECT s.currentPrice FROM securities s WHERE s.id = transactions.securityID),
        0
    )
WHERE type = 'N'
  AND securityID IS NOT NULL
  AND id = (
    SELECT t2.id FROM transactions t2
    WHERE t2.securityID = transactions.securityID AND t2.type = 'N'
    ORDER BY t2.date ASC, t2.id ASC
    LIMIT 1
  );

-- 7e-bis. Safety net: a transactions-mode account may hold a migrated
--         security that had no cash trades of its own (e.g. the account
--         has 'N' trades from a different asset). Without a backing trade
--         the position would vanish when replayed, so create a zero-cash
--         anchor buy (value 0 keeps the account balance unchanged, the
--         security value was already counted as a valuation pre-v13).
--         The title is left NULL: a migration cannot know the user's locale,
--         and the app already renders untitled 'N' rows with a translated
--         label.
INSERT INTO transactions (id, date, accountID, value, title, type, securityID, quantity, pricePerUnit, isHidden)
SELECT 'anchor_' || h.id, COALESCE(s.priceDate, DATE('now')), h.accountID, 0,
       NULL, 'N', h.securityID, 1, COALESCE(s.currentPrice, 0), 0
FROM holdings h
JOIN securities s ON s.id = h.securityID
JOIN accounts a ON a.id = h.accountID
WHERE a.trackingMode = 'transactions'
  AND NOT EXISTS (
    SELECT 1 FROM transactions t
    WHERE t.securityID = h.securityID AND t.accountID = h.accountID AND t.type = 'N'
  );

-- 7f. Remove the converted financial assets and their valuations.
DELETE FROM valuations
WHERE assetId IN (SELECT id FROM assets WHERE assetType IN ('stocks', 'funds', 'crypto'));

DELETE FROM assets
WHERE assetType IN ('stocks', 'funds', 'crypto');

-- ------------------------------------------------------------
-- Step 8: Rebuild `assets` as physical-only and add `linkedDebtId`.
-- (All financial assets have been converted/removed above.)
-- We create `assets_new`, copy, DROP `assets`, then rename the new
-- table into place, so child FKs (valuations, transactions) keep
-- pointing at `assets` instead of being rewritten to a temp name.
-- ------------------------------------------------------------
CREATE TABLE assets_new (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    initialValue REAL NOT NULL DEFAULT 0,
    creationDate TEXT NOT NULL,
    assetType TEXT NOT NULL DEFAULT 'other' CHECK(assetType IN ('real_estate', 'vehicle', 'precious_metal', 'jewelry_art', 'other')),
    linkedAccountID TEXT REFERENCES accounts(id) ON DELETE SET NULL ON UPDATE CASCADE,
    linkedDebtId TEXT REFERENCES debts(id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO assets_new (id, name, description, currencyId, initialValue, creationDate, assetType, linkedAccountID, linkedDebtId)
SELECT id, name, description, currencyId, initialValue, creationDate, assetType, linkedAccountID, NULL
FROM assets;

DROP TABLE assets;

ALTER TABLE assets_new RENAME TO assets;

-- ------------------------------------------------------------
-- Step 9: New security-classification tables (taxonomies). The
-- default built-in taxonomies/categories are seeded from Dart
-- (TaxonomyService.ensureSeeded, which runs on every open and seeds
-- when the taxonomies table is empty), so here we only create the
-- empty tables. This keeps the seed a single source of truth shared
-- by fresh installs and upgrades.
-- ------------------------------------------------------------
CREATE TABLE taxonomies (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    color TEXT NOT NULL DEFAULT '#8abceb',
    description TEXT,
    isSystem INTEGER NOT NULL DEFAULT 0,
    isSingleSelect INTEGER NOT NULL DEFAULT 0,
    displayOrder INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE taxonomyCategories (
    id TEXT NOT NULL PRIMARY KEY,
    taxonomyID TEXT NOT NULL REFERENCES taxonomies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    parentID TEXT REFERENCES taxonomyCategories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name TEXT NOT NULL,
    color TEXT NOT NULL DEFAULT '#808080',
    description TEXT,
    displayOrder INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_taxonomyCategories_taxonomyID ON taxonomyCategories(taxonomyID);

CREATE TABLE securityTaxonomyAssignments (
    id TEXT NOT NULL PRIMARY KEY,
    securityID TEXT NOT NULL REFERENCES securities(id) ON DELETE CASCADE ON UPDATE CASCADE,
    taxonomyID TEXT NOT NULL REFERENCES taxonomies(id) ON DELETE CASCADE ON UPDATE CASCADE,
    categoryID TEXT NOT NULL REFERENCES taxonomyCategories(id) ON DELETE CASCADE ON UPDATE CASCADE,
    weight INTEGER NOT NULL DEFAULT 10000 CHECK(weight >= 0 AND weight <= 10000),
    UNIQUE(securityID, taxonomyID, categoryID)
);

CREATE INDEX idx_securityTaxonomyAssignments_securityID ON securityTaxonomyAssignments(securityID);
CREATE INDEX idx_securityTaxonomyAssignments_taxonomyID ON securityTaxonomyAssignments(taxonomyID);
