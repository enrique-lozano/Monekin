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