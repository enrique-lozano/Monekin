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
