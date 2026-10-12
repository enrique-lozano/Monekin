-- ============================================================
-- v14 Migration: portfolio snapshots also declare CASH
--   * `accountSnapshots` gains a `cash` column (account currency).
--
-- A snapshot is the account's authoritative state on its date:
-- positions AND cash. From that date on the declared cash is the cash
-- balance, and transactions posted after it accumulate on top. Income,
-- expenses and transfers keep working and keep their history.
--
-- Existing snapshots are backfilled with the ledger cash at each
-- snapshot date (opening balance + counted transactions up to that
-- date, in the account currency), so balances stay unchanged after
-- upgrading. Nothing is deleted and no row is rewritten beyond this
-- new column.
-- ============================================================

-- ------------------------------------------------------------
-- Step 1: Add the column. A non-null default keeps the existing rows
-- valid while they are still un-backfilled (the UPDATE below runs in the
-- same transaction, so no intermediate state is ever visible).
-- ------------------------------------------------------------
ALTER TABLE accountSnapshots ADD COLUMN cash REAL NOT NULL DEFAULT 0;

-- ------------------------------------------------------------
-- Step 2: Backfill with the ledger cash at each snapshot's date.
--
-- The ledger effect of a transaction on the account mirrors how the app
-- aggregates rows (see TransactionService._countTransactions):
--   * income / expense / investment ('E', 'I', 'N'): the signed value,
--   * transfer, account is the origin: minus the value,
--   * transfer, account is the destination: plus valueInDestiny (which
--     falls back to the value when both sides share a currency).
-- Voided ('V') and pending ('P') rows never count towards balances.
--
-- The opening balance is only counted when the account already existed
-- on the snapshot date, matching AccountService.
--
-- The outer COALESCE is a safety net. FK enforcement is off while a
-- migration runs, so a snapshot orphaned by an already-corrupt database
-- gets 0 instead of failing the NOT NULL constraint and rolling back the
-- whole upgrade.
-- ------------------------------------------------------------
UPDATE accountSnapshots
SET cash = COALESCE(
  (
    SELECT
      (CASE WHEN a.date > accountSnapshots.date THEN 0 ELSE a.iniValue END)
      + COALESCE(
          (
            SELECT SUM(
              CASE
                WHEN t.type != 'T' THEN t.value
                WHEN t.accountID = a.id THEN -t.value
                ELSE COALESCE(t.valueInDestiny, t.value)
              END
            )
            FROM transactions t
            WHERE (t.status IS NULL OR t.status NOT IN ('V', 'P'))
              AND t.date <= accountSnapshots.date
              AND (
                t.accountID = a.id
                OR (t.type = 'T' AND t.receivingAccountID = a.id)
              )
          ),
          0
        )
    FROM accounts a
    WHERE a.id = accountSnapshots.accountID
  ),
  0
);
