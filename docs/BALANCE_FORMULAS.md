# Balance Formulas

This document describes how account balances, asset values, and net worth are computed in Monekin from a financial perspective.

---

## 1. Account balance

For every account $a$ (normal, saving, or investment), the **balance** at date $t$ is the sum of three parts: opening balance, **cash ledger** net from transactions, and **linked holdings** market value.

$$
\text{AccountValue}(a,t) = \text{Ini}(a,t) + L(a,t) + H(a,t)
$$

| Term | Meaning |
| --- | --- |
| $\text{Ini}(a,t)$ | **Opening balance** at account creation, counted only if the account exists on or before $t$; otherwise $0$. |
| $L(a,t)$ | **Cash ledger net** — effect of all counted transactions on account $a$ with date $\leq t$ (see below). |
| $H(a,t)$ | **Linked holdings value** — sum of market values of all assets that belong to account $a$ via a link from asset to account. If there are none, $H(a,t)=0$. |

### 1.1 Cash ledger net $L(a,t)$

Transactions are aggregated with **signed amounts** as stored for the account:

- **Income** and **investment (cash leg)** rows use the stored `value` (income is positive in normal use).
- **Expense** rows use a negative stored `value` for the same magnitude as the expense.
- **Transfers** reduce the origin account by the outgoing amount and increase the receiving account by the received amount (using destination currency amounts when applicable).

Only statuses that count toward statistics (typically confirmed / reconciled; not pending or voided) are included. When balances are shown in a **reference currency**, each piece is converted using exchange rates as of $t$.

> **Implementation:** `TransactionService.getTransactionsValueBalance()` with filters scoped to account $a$ and `maxDate` $t$.

### 1.2 Linked holdings $H(a,t)$

Each **asset** linked to account $a$ has a market value $\text{AssetValue}(s,t)$ (section 2). Linked holdings are:

$$
H(a,t) = \sum_{s \,:\, \text{linked}(s)=a} \text{AssetValue}(s,t)
$$

For normal and saving accounts, users typically have no linked assets, so $H(a,t)=0$. For investment accounts, linked assets represent positions (e.g., funds, securities) whose value is tracked separately and added to the cash ledger.

> **Implementation:** `InvestmentService.streamLinkedAssetsTotalForAccount()` (internally sums `InvestmentService.getAssetValueAtDate()` per linked asset).

### 1.3 Combined account stream

$$
\text{AccountValue}(a,t) = \text{Ini}(a,t) + L(a,t) + H(a,t)
$$

with rounding applied in the account’s display currency when not converting.

> **Implementation:** `AccountService.getAccountMoney()` for one account; `AccountService.getAccountsMoney()` for many accounts (same structure: sum of openings + pooled ledger net + sum of linked-holdings terms for investment accounts in scope).

---

## 2. Asset market value

An **asset** $s$ (any type) has a time series of **valuations** (user snapshots of worth). Its value at $t$ is:

$$
\text{AssetValue}(s,t) =
\begin{cases}
0 & \text{if } t \text{ is before the asset’s creation date} \\
\text{LatestValuation}(s,t) & \text{if at least one valuation exists on or before } t \\
\text{InitialValue}(s) & \text{otherwise}
\end{cases}
$$

$\text{LatestValuation}(s,t)$ is the valuation on the latest date $\leq t$. $\text{InitialValue}(s)$ is the value set when the asset was created.

> **Implementation:** `InvestmentService.getAssetValueAtDate()`; current date with no $t$ argument: `InvestmentService.getCurrentAssetValue()`.

---

## 3. Asset gain vs. booked initial

For reporting on a single asset, the app compares current market value to the asset’s **booked initial** amount (the creation-time initial value, not a full cost-basis reconstruction from every trade):

$$
\text{Gain}(s) = \text{AssetValue}(s,t_{\text{now}}) - \text{InitialValue}(s)
$$

$$
\text{Gain\%}(s) = \frac{\text{Gain}(s)}{\text{InitialValue}(s)} \quad (\text{when } \text{InitialValue}(s) \neq 0)
$$

When $\text{InitialValue}(s)=0$, the percentage is undefined; the app uses a sentinel pair of infinities for UI logic (`getAssetProfit`).

> **Implementation:** `InvestmentService.getAssetProfit()`.

---

## 4. Net worth (assets side)

On the **assets side**, net worth sums **account balances** and **standalone assets**, without double-counting:

$$
\text{AssetsSide}(t) = \sum_{a \in A^{*}} \text{AccountValue}(a,t) \;+\; \sum_{s \in S_0} \text{AssetValue}(s,t)
$$

| Set | Description |
| --- | --- |
| $A^{*}$ | Open accounts included in net worth. Investment accounts use $\text{AccountValue}$ as in section 1 (cash ledger + linked holdings). |
| $S_0$ | **Standalone assets** — assets with no linked account. Assets linked to an account are omitted from this sum because their value is already inside that account’s $\text{AccountValue}$. |

All amounts are converted to the user’s preferred currency before summing. Any **debt** subtraction used in net-worth screens is a separate liability term in the app, not part of $\text{AccountValue}$.

> **Implementation:** per-account `AccountService.getAccountMoney()`; standalone-asset total `InvestmentService.getTotalAssetsValueAtDate(considerLinkedAccounts: false)` when aggregating net worth so linked assets are not summed twice.
