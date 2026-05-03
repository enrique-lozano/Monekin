# Balance Formulas

This document describes how account balances, asset values, and **net worth** are computed in Monekin.

---

## 1. Account balance (single account)

Section 1 defines **one account’s** balance at date $t$, denoted $\text{AccountValue}(a,t)$. Net worth (section 4) **aggregates** these same quantities across accounts; it is not a different kind of balance.

For every account $a$ (normal, saving, or investment):

$$
\text{AccountValue}(a,t) = \text{Ini}(a,t) + L(a,t) + H(a,t)
$$

| Term              | Meaning                                                                                                                                                    |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| $\text{Ini}(a,t)$ | **Opening balance** at account creation, counted only if the account exists on or before $t$; otherwise $0$.                                               |
| $L(a,t)$          | **Cash ledger net** — effect of all counted transactions on account $a$ with date $\leq t$.                                                                  |
| $H(a,t)$          | **Linked holdings** — sum of market values of assets **linked** to account $a$. If none, $H(a,t)=0$.                                                         |

### 1.1 Cash ledger net $L(a,t)$

Transactions use **signed** stored `value` (expenses negative, income positive in normal use). **Transfers** net outflows from the origin account and inflows to the destination (using `valueInDestiny` when applicable). **Investment-type** rows are the **cash leg** of buys/sells. Pending / voided rows are excluded from statistics in the usual way. Amounts can be converted to a reference currency using rates as of $t$.

> **Implementation:** `TransactionService.getTransactionsValueBalance()` with filters scoped to account $a$ and `maxDate` $t$.

### 1.2 Linked holdings $H(a,t)$

$$
H(a,t) = \sum_{s \,:\, \text{linked}(s)=a} \text{AssetValue}(s,t)
$$

$\text{AssetValue}$ is defined in section 2. For typical cash accounts, $H(a,t)=0$. For investment accounts, linked assets are positions (funds, securities, etc.) whose market value is added on top of the cash ledger.

> **Implementation:** `InvestmentService.streamLinkedAssetsTotalForAccount()` (sums `getAssetValueAtDate` per linked asset).

Rounding in the account’s currency applies when not converting. For several accounts at once, the app sums opening balances, pooled ledger effects, and linked-holdings terms the same way.

> **Implementation:** `AccountService.getAccountMoney(account: …)`; `AccountService.getAccountsMoney(…)` for many accounts.

---

## 2. Asset market value

For an **asset** $s$ (any row in the assets table), value at $t$:

$$
\text{AssetValue}(s,t) =
\begin{cases}
0 & \text{if } t \text{ is before the asset’s creation date} \\
\text{LatestValuation}(s,t) & \text{if at least one valuation exists on or before } t \\
\text{InitialValue}(s) & \text{otherwise}
\end{cases}
$$

> **Implementation:** `InvestmentService.getAssetValueAtDate()`; “now”: `getCurrentAssetValue()`.

---

## 3. Asset gain vs. booked initial

$$
\text{Gain}(s) = \text{AssetValue}(s,t_{\text{now}}) - \text{InitialValue}(s)
$$

$$
\text{Gain\%}(s) = \frac{\text{Gain}(s)}{\text{InitialValue}(s)} \quad (\text{when } \text{InitialValue}(s) \neq 0)
$$

When $\text{InitialValue}(s)=0$, the percentage is undefined; the app uses signed infinities for display edge cases.

> **Implementation:** `InvestmentService.getAssetProfit()`.

---

## 4. Net worth

**Net worth** answers: “What is everything worth, minus what I owe?” It is computed in the **user’s preferred currency**.

It is **not** a repeat of section 1.3: section 1 defines $\text{AccountValue}(a,t)$ for **each** account $a$. Here we **add** those balances across accounts, **add** only **standalone** assets (so linked portfolio assets are not counted twice), then **subtract** debts.

### 4.1 Gross assets

**Gross assets** at $t$ (the “Assets” line in the net-worth evolution chart):

$$
\text{Gross}(t) = \underbrace{\sum_{a \in A} \text{AccountValue}(a,t)}_{\text{all accounts, same } \text{AccountValue} \text{ as §1}} \;+\; \underbrace{\sum_{s \in S_0} \text{AssetValue}(s,t)}_{\text{standalone assets only}}
$$

- $A$: set of accounts included in the sum (today: every account; each investment account already includes its linked assets inside $\text{AccountValue}$).
- $S_0$: assets with **no** linked account. Assets linked to an account are **not** in this sum — their value is already inside that account’s $\text{AccountValue}(a,t)$ via $H(a,t)$.

Equivalently in code: **sum of all account balances** plus **standalone asset total**:

> **Implementation:** `NetWorthService.getGrossAssetsAtDate(t)` = `AccountService.getAccountsMoney(date: t)` + `InvestmentService.getStandaloneAssetsValueAtDate(date: t)`.

Optional transaction filters can be passed through for stats consistency (`TransactionFilterSet`).

### 4.2 Liabilities (debts)

**Debts** is the sum of each debt’s **remaining** balance, converted to the preferred currency. Conversion uses exchange rates as of the same date $t$ used on the chart point; remaining amounts follow the live debt ledger (same behaviour as the net-worth chart).

> **Implementation:** `NetWorthService.getTotalDebtsInPreferredCurrency(exchangeRateAsOf: t)`.

### 4.3 Net worth

$$
\text{NetWorth}(t) = \text{Gross}(t) - \text{Debts}(t)
$$

> **Implementation:** `NetWorthService.getNetWorthAtDate(t)`.

The composition pie splits **gross** into three UI buckets (non-investment accounts, investment accounts, standalone assets); their amounts sum to $\text{Gross}(t)$.

### 4.4 Period balance trend (dashboard / stats)

Relative change in **combined** balance for selected accounts between two dates, as a fraction (e.g. `0.05` → +5% when shown as a percent):

$$
\frac{B_{\mathrm{end}} - B_{\mathrm{start}}}{B_{\mathrm{start}}}
$$

where $B$ is the same total as `getAccountsMoney` for those accounts. Near-zero start uses a safe sentinel in code.

> **Implementation:** `AccountService.getAccountsBalanceRelativeChange()`.
