-- ----------- ADDING TRANSACTION TYPE COLUMN ------------

-- Step 1: Create a new table with the 'type' column defined as NOT NULL
CREATE TABLE transactions_temp (
  id TEXT NOT NULL PRIMARY KEY,
  date DATETIME NOT NULL,
  accountID TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  value REAL NOT NULL,
  title TEXT,
  notes TEXT,

  -- New column:
  type TEXT NOT NULL CHECK(type IN ('E', 'I', 'T')),
  
  status TEXT CHECK(status IN ('voided', 'pending', 'reconciled', 'unreconciled')),
  categoryID TEXT REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE,
  valueInDestiny REAL,
  receivingAccountID TEXT REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  isHidden BOOLEAN NOT NULL DEFAULT 0,

  -- NEW LOCATION DATA --
  locLatitude REAL,
  locLongitude REAL,
  locAddress TEXT,

  intervalPeriod TEXT CHECK(intervalPeriod IN ('day','week','month','year')),
  intervalEach INTEGER,
  endDate DATETIME,
  remainingTransactions INTEGER,

  CHECK ((receivingAccountID IS NULL) != (categoryID IS NULL)),
  CHECK ((intervalPeriod IS NULL) == (intervalEach IS NULL)),
  CHECK ((intervalPeriod IS NOT NULL) OR (endDate IS NULL)),
  CHECK ((intervalPeriod IS NOT NULL) OR (remainingTransactions IS NULL)),
  CHECK (categoryID IS NULL OR valueInDestiny IS NULL),

  -- Location data checks:
  CHECK ((locLongitude IS NULL AND locLatitude IS NULL) OR (locLongitude IS NOT NULL AND locLatitude IS NOT NULL)),
  CHECK ((locAddress IS NULL) OR (locLatitude IS NOT NULL AND locLongitude IS NOT NULL))
);


-- Step 2: Copy the data from the old table to the new table
INSERT INTO transactions_temp (
 id,
 date,
 accountID,
 value,
 title,
 notes,
 type,
 status,
 categoryID,
 valueInDestiny,
 receivingAccountID,
 isHidden,
 intervalPeriod,
 intervalEach,
 endDate,
 remainingTransactions
) SELECT id,
    date,
    accountID,
    value,
    title,
    notes,
    CASE 
        WHEN receivingAccountID IS NOT NULL THEN 'T' 
        WHEN value < 0 THEN 'E' 
        WHEN value > 0 THEN 'I' 
        ELSE NULL 
    END AS type,
    status,
    categoryID,
    valueInDestiny,
    receivingAccountID,
    isHidden,
    intervalPeriod,
    intervalEach,
    endDate,
    remainingTransactions
FROM transactions;

-- Step 3: Drop the old table
DROP TABLE transactions;

-- Step 4: Rename the new table to the original table name
ALTER TABLE transactions_temp RENAME TO transactions;

-- ----------- ADDING CURRENCY NAME TO `currencies` TABLE ------------

-- Add the new column
ALTER TABLE currencies ADD COLUMN name TEXT;

-- Set all currency names to "Unknown Currency"
UPDATE currencies SET name = 'Unknown Currency';

-- Retrieve the language setting and update the 'name' column based on the language prefix
-- Update the 'name' column for languages starting with 'es'
UPDATE currencies
SET name = (
    SELECT cn.es
    FROM currencyNames cn
    WHERE cn.currencyCode = currencies.code
)
WHERE lower((SELECT settingValue FROM userSettings WHERE settingKey = 'appLanguage')) LIKE 'es%';

-- Update the 'name' column for other languages (default to English)
UPDATE currencies
SET name = (
    SELECT cn.en
    FROM currencyNames cn
    WHERE cn.currencyCode = currencies.code
)
WHERE lower((SELECT settingValue FROM userSettings WHERE settingKey = 'appLanguage')) NOT LIKE 'es%';


-- To add the NOT NULL constraint we have to create a copy of the table with the new constraint 
PRAGMA foreign_keys = 0;

CREATE TABLE sqlitestudio_temp_table AS SELECT *
                                          FROM currencies;

DROP TABLE currencies;

CREATE TABLE currencies (
    code   TEXT NOT NULL
                PRIMARY KEY,
    symbol TEXT NOT NULL,
    name   TEXT NOT NULL
);

INSERT INTO currencies (
                           code,
                           symbol,
                           name
                       )
                       SELECT code,
                              symbol,
                              name
                         FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

PRAGMA foreign_keys = 1;

-- Drop the table with the uneeded translations
DROP TABLE currencyNames;
