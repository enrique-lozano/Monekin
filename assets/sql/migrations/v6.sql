DELETE FROM userSettings WHERE settingKey = 'transactionMobileMode';

ALTER TABLE accounts ADD COLUMN color TEXT;

ALTER TABLE accounts ADD COLUMN displayOrder INTEGER NOT NULL DEFAULT 0;