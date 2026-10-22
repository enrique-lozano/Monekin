-- ============================================================
-- v15 Migration: credit card accounts
--   * New account type `credit` (a revolving credit line, its balance
--     is the debt with the bank and is usually negative).
--   * Accounts gain four optional columns, only meaningful for
--     `credit` accounts:
--       - cutoffDay: day of the month the statement closes (1-31)
--       - dueDay: day of the month the statement has to be paid (1-31)
--       - creditLimit: credit limit, in the account currency
--       - minPaymentPct: share of the statement used to estimate the
--         minimum payment (e.g. 0.05 for 5%)
--     Days that a month does not have (29, 30, 31) fall back to the
--     last day of that month.
--
-- INVARIANT: a `credit` account always has a non-null cutoffDay and
-- dueDay. It is validated by the account form and assumed by the
-- queries instead of being expressed as a CHECK constraint.
--
-- Existing accounts keep their type and get NULL in the new columns.
-- Nothing else is rewritten.
-- ============================================================

-- The type lives in a CHECK constraint, so the table has to be rebuilt.
-- We create a new table and swap it in (instead of renaming the original
-- to *_old) so that foreign keys in child tables keep pointing at
-- `accounts`.
CREATE TABLE accounts_new (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    groupName TEXT,
    iniValue REAL NOT NULL,
    date TEXT NOT NULL,
    description TEXT,
    type TEXT NOT NULL CHECK(type IN ('money', 'investment', 'credit')),
    isSaving INTEGER NOT NULL DEFAULT 0,
    trackingMode TEXT NOT NULL DEFAULT 'transactions' CHECK(trackingMode IN ('transactions', 'holdings')),
    iconId TEXT NOT NULL,
    displayOrder INTEGER NOT NULL,
    color TEXT,
    closingDate TEXT,
    currencyId TEXT NOT NULL REFERENCES currencies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    iban TEXT,
    swift TEXT,
    cutoffDay INTEGER CHECK(cutoffDay IS NULL OR cutoffDay BETWEEN 1 AND 31),
    dueDay INTEGER CHECK(dueDay IS NULL OR dueDay BETWEEN 1 AND 31),
    creditLimit REAL,
    minPaymentPct REAL
);

INSERT INTO accounts_new (id, name, groupName, iniValue, date, description, type, isSaving, trackingMode, iconId, displayOrder, color, closingDate, currencyId, iban, swift)
SELECT id, name, groupName, iniValue, date, description, type, isSaving, trackingMode, iconId, displayOrder, color, closingDate, currencyId, iban, swift
FROM accounts;

DROP TABLE accounts;

ALTER TABLE accounts_new RENAME TO accounts;
