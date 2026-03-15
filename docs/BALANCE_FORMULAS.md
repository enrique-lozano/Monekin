# Balance Formulas

This document describes how account balances are computed across different account types in Monekin.

---

## Normal and Saving Accounts

**Formula:**

```
balance = iniValue
        + Σ income (type = 'I', status not in {'P', 'V'}, date ≤ targetDate)
        - Σ expense (type = 'E', status not in {'P', 'V'}, date ≤ targetDate)
        + Σ transfer valueInDestiny (receivingAccountID = accountId, status not in {'P', 'V'}, date ≤ targetDate)
        - Σ transfer value (accountID = accountId, type = 'T', status not in {'P', 'V'}, date ≤ targetDate)
```

**Implementation:**

- `AccountService.getAccountsMoney()` in `lib/core/database/services/account/account_service.dart`
- Two sub-streams are combined via `Rx.combineLatest`:
  1. **Initial balance** — raw SQL `SUM(iniValue)` for rows with `accounts.date ≤ targetDate`
  2. **Transaction balance** — `TransactionService.getTransactionsValueBalance()`

**Key notes:**

- `iniValue` is skipped (treated as 0) when `accounts.date > targetDate` — the account had not been opened yet.
- Exchange rates are applied when `convertToPreferredCurrency = true`.
- Pending (`'P'`) and voided (`'V'`) transactions are excluded.

---

## Investment Accounts

**Formula:**

```
balance = latestValuation(account) ?? investedCapital(account)
```

Where:

```
investedCapital = iniValue
                + Σ transfer valueInDestiny (receivingAccountID = accountId, type = 'T', status not in {'P', 'V'})
                - Σ transfer value          (accountID = accountId,          type = 'T', status not in {'P', 'V'})
```

**Interpretation:**

- If the user has recorded at least one **valuation** for the account, the latest valuation value is used as the balance.
- Otherwise, the balance falls back to `investedCapital` — the net amount of money the user has transferred into the investment account.

**Implementation split:**

| Method                        | Location            | Role                                                                   |
| ----------------------------- | ------------------- | ---------------------------------------------------------------------- |
| `getPortfolioValue(account)`  | `InvestmentService` | Current balance (valuation or fallback)                                |
| `getInvestedCapital(account)` | `InvestmentService` | Total money put into the account                                       |
| `getAccountMoney(account:)`   | `AccountService`    | Entry point — delegates to `getPortfolioValue` for investment accounts |

**Key notes:**

- Only the `getAccountMoney()` single-account overload short-circuits for investment accounts. The multi-account `getAccountsMoney()` still uses the SQL sum path — do not pass investment account IDs directly to it without modification.
- Profit is `portfolioValue - investedCapital`; profit % is `profit / investedCapital`.
- Valuations are stored in the `valuations` table with `accountId` set and `assetId` NULL.

---

## Assets (Stand-alone)

Assets are not accounts. Their "balance" is:

```
value = latestValuation(asset) ?? asset.initialValue
```

Tracked via `InvestmentService.getAssetValue(asset)`.

---

## Net Worth

Net worth sums three components in the user's preferred currency:

```
netWorth = Σ balance(normal/saving accounts where includeInNetWorth = 1 and not closed)
         + Σ portfolioValue(investment accounts where includeInNetWorth = 1 and not closed)
         + Σ value(assets where includeInNetWorth = 1)
```

Net worth is derived from:

- non-investment account balances (`iniValue + transactions`)
- investment account portfolio values (latest valuation at/before date, fallback to invested capital)
- assets (latest valuation, fallback to initial value)
