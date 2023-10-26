INSERT INTO userSettings VALUES ('accentColor', 'auto'),
('amoledMode', '0');

CREATE TABLE IF NOT EXISTS tags (
    id TEXT PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    color TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS transactionTags (
  transactionID TEXT NOT NULL REFERENCES transactions(id) ON DELETE CASCADE ON UPDATE CASCADE,
  tagID TEXT NOT NULL REFERENCES tags(id) ON DELETE CASCADE ON UPDATE CASCADE
);