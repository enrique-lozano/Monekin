--- New currencies columns
ALTER TABLE currencies ADD COLUMN decimalPlaces INTEGER NOT NULL DEFAULT 2;
ALTER TABLE currencies ADD COLUMN isDefault BOOLEAN NOT NULL DEFAULT 1;

-- Currency type:
-- 0 = fiat
-- 1 = crypto
-- 2 = other
ALTER TABLE currencies ADD COLUMN type INTEGER NOT NULL DEFAULT 0;

-- Update currencies with 3 decimal places
UPDATE currencies 
SET decimalPlaces = 3 
WHERE code IN ('BHD', 'IQD', 'JOD', 'KWD', 'LYD', 'OMR', 'TND');

-- Update currencies with 0 decimal places
UPDATE currencies 
SET decimalPlaces = 0 
WHERE code IN (
    'BIF', 'CLP', 'DJF', 'GNF', 'JPY', 'KMF', 'KRW', 'LAK', 'PYG', 
    'RWF', 'TWD', 'UGX', 'VND', 'VUV', 'XAF', 'XOF', 'XPF'
);

-- Add new cryptocurrencies
INSERT INTO currencies (code, symbol, name, decimalPlaces, type, isDefault)
VALUES ('BTC', '₿', 'Bitcoin', 6, 1, 0);

INSERT INTO currencies (code, symbol, name, decimalPlaces, type, isDefault)
VALUES ('ETH', 'Ξ', 'Ethereum', 6, 1, 0);

------- SAVE FILTERS AND TRANSACTION FILTERS -------

-- Create new tables
CREATE TABLE transactionFilterSets (
    id TEXT NOT NULL PRIMARY KEY,
    accountsIDs TEXT,
    categoriesIds TEXT,
    status TEXT,
    minDate DATETIME,
    maxDate DATETIME,
    searchValue TEXT,
    transactionTypes TEXT,
    isRecurrent BOOLEAN,
    minValue REAL,
    maxValue REAL,
    tagsIDs TEXT
);

CREATE TABLE savedFilters (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    displayOrder INTEGER NOT NULL,
    filterID TEXT NOT NULL REFERENCES transactionFilterSets(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Migrate existing budget filters to transactionFilterSets
INSERT INTO transactionFilterSets (id, categoriesIds, accountsIDs)
SELECT 
    b.id || '_filter',
    NULLIF((SELECT json_group_array(categoryID) FROM budgetCategory WHERE budgetID = b.id), '[]'),
    NULLIF((SELECT json_group_array(accountID) FROM budgetAccount WHERE budgetID = b.id), '[]')
FROM budgets b;

-- Add filterID to budgets
ALTER TABLE budgets ADD COLUMN filterID TEXT REFERENCES transactionFilterSets(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Link budgets to their filters
UPDATE budgets SET filterID = id || '_filter';

-- Drop old tables
DROP TABLE budgetCategory;
DROP TABLE budgetAccount;

--- ----------- NEW USER SETTINGS ------------
INSERT INTO userSettings VALUES ('defaultTransactionType', 'E');

--- ----------- TRANSACTION STATUS MIGRATION ------------
-- 1. Add new temporary column with the new check constraint
ALTER TABLE transactions ADD COLUMN status_new TEXT CHECK(status_new IN ('V', 'P', 'R', 'U'));

-- 2. Migrate data from old column to new column
UPDATE transactions SET status_new = 'V' WHERE status = 'voided';
UPDATE transactions SET status_new = 'P' WHERE status = 'pending';
UPDATE transactions SET status_new = 'R' WHERE status = 'reconciled';
UPDATE transactions SET status_new = 'U' WHERE status = 'unreconciled';

-- 3. Drop the old column and rename the new column to the original name
ALTER TABLE transactions DROP COLUMN status;
ALTER TABLE transactions RENAME COLUMN status_new TO status;