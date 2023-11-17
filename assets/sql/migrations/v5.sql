INSERT INTO userSettings VALUES ('accentColor', 'auto'),
('amoledMode', '0');

CREATE TABLE IF NOT EXISTS tags (
    id TEXT NOT NULL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    color TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS transactionTags (
  transactionID TEXT NOT NULL REFERENCES transactions(id) ON DELETE CASCADE ON UPDATE CASCADE,
  tagID TEXT NOT NULL REFERENCES tags(id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE accounts ADD COLUMN closingDate TEXT;

UPDATE accounts
SET closingDate = strftime('%Y-%m-%dT%H:%M:%fZ', 'now', 'localtime')
WHERE isArchived == 1;

ALTER TABLE accounts DROP COLUMN isArchived;