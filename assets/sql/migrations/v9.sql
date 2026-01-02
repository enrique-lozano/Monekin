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