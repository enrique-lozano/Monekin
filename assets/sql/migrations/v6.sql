DELETE FROM userSettings WHERE settingKey = 'transactionMobileMode';

ALTER TABLE accounts ADD COLUMN color TEXT;