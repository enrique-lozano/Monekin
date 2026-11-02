# Balance Formulas

This document describes how account balances, portfolio values, asset values, and **net worth** are computed in Monekin.

For the concepts behind these numbers (securities, holdings, tracking modes, snapshots), see [INVESTMENTS_AND_ASSETS.md](./INVESTMENTS_AND_ASSETS.md).

Two things to know before reading any formula:

- **Everything is evaluated as of a date**, never from today's state. Asking what an account was worth last March reconstructs the quantities and prices of last March.
- **Net worth is not a different kind of balance.** [Account balance](#1-account-balance) defines the value of *one* account; [Net worth](#4-net-worth) adds those same values across accounts, adds every asset, and subtracts debts.

## Contents

1. [Account balance](#1-account-balance) — one account, and several at once
2. [Position cost and profit](#2-position-cost-and-profit) — what a holding cost and what it gained
3. [Assets](#3-assets) — physical property and its value over time
4. [Net worth](#4-net-worth) — everything, minus what you owe

## Notation

| Symbol | Meaning |
| ------ | ------------------------------------------------------------------ |
| $t$    | The date the value is evaluated at.                                |
| $a$    | An account.                                                        |
| $s$    | A security (a stock, fund or crypto asset).                        |
| $x$    | An asset (physical property: a flat, a car, gold).                 |
| $d$    | The date of the portfolio snapshot in effect at $t$, if there is one. |

---

## 1. Account balance

For every account $a$ (money, saving, or investment):

$$
\text{AccountValue}(a,t) = \underbrace{\text{Ini}(a,t) + L(a,t) + A(a,t)}_{\text{cash}} + H(a,t)
$$

| Term              | Meaning                                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------------------------ |
| $\text{Ini}(a,t)$ | **Opening balance** at account creation, counted only if the account exists on or before $t$; otherwise $0$. |
| $L(a,t)$          | **Cash ledger net** — effect of all counted transactions on account $a$ with date $\leq t$. See [Cash ledger net](#11-cash-ledger-net). |
| $A(a,t)$          | **Snapshot anchor** — correction that lets a portfolio snapshot own the cash of a `holdings`-mode account. $0$ for every other account. See [Snapshot anchor](#13-snapshot-anchor). |
| $H(a,t)$          | **Holdings** — market value of the securities held in account $a$ at $t$. For cash accounts, $H(a,t)=0$. See [Holdings market value](#12-holdings-market-value). |

The first three terms are the account's **cash**, which is also available on its own.

Assets are **not** part of any account: physical property stands on its own and is added directly to net worth.

> **Implementation:** `AccountService.getAccountCash()` for the cash side, `AccountService.getAccountMoney()` for the total. Results are rounded in the account's currency when not converting.

### 1.1 Cash ledger net

$L(a,t)$ is the net effect of every counted transaction on the account.

Transactions use **signed** stored `value` (expenses negative, income positive in normal use). **Transfers** net outflows from the origin account and inflows to the destination (using `valueInDestiny` when applicable). **Investment-type** rows (`N`) are the **cash leg** of buys and sells: buying shares removes cash from the ledger and adds it to $H$, so the account total doesn't jump. Pending / voided rows are excluded from statistics in the usual way. Amounts can be converted to a reference currency using rates as of $t$.

> **Implementation:** `TransactionService.getTransactionsValueBalance()` with filters scoped to account $a$ and `maxDate` $t$.

### 1.2 Holdings market value

$$
H(a,t) = \sum_{s \,\in\, \text{Pos}(a,t)} q(a,s,t) \times p(s,t)
$$

Every factor is resolved **as of $t$**:

- $\text{Pos}(a,t)$ — every security the account has ever held, taken from its activity rather than from the current `holdings` rows, so a position sold before $t$ still counts on earlier dates.
- $q(a,s,t)$ — units held at $t$. In `transactions` tracking mode, the trades up to $t$ replayed in order. In `holdings` mode, the quantity in the most recent snapshot on or before $t$ (0 when the security is absent from it, which is how a sale is expressed).
- $p(s,t)$ — the latest price observation on or before $t$, falling back to the security's `currentPrice`.

Each position is summed in its security's own currency and converted from there, so an account holding instruments quoted in different currencies is valued correctly.

> **Implementation:** `HoldingService.getHoldingsMarketValue()`, built on the single time-aware query `HoldingService._watchPositionValuations()`.

### 1.3 Snapshot anchor

An account tracked in `holdings` mode takes its state from portfolio snapshots. A snapshot states the account's whole state on its date — its positions *and* its cash — and from that date on the declared **cash** is the cash balance. Only the cash is settled this way: the declared positions are still valued at the price of whatever date is being asked about, through $H(a,t)$ above. Transactions dated after the snapshot accumulate on top of the declared cash, which is what keeps interest, taxes, transfers and ordinary income/expenses working on these accounts; transactions dated *on* the snapshot date count as part of what it already reconciled.

With $d$ the date of the latest snapshot on or before $t$:

$$
A(a,t) =
\begin{cases}
0 & \text{if } a \text{ is not in } \text{holdings} \text{ mode, or has no snapshot on or before } t \\
\text{SnapshotCash}(a,d) - \bigl(\text{Ini}(a,d) + L(a,d)\bigr) & \text{otherwise}
\end{cases}
$$

Substituted into the balance formula above, the opening balance and the pre-snapshot ledger both cancel out, and the cash side collapses to what the user actually declared plus everything posted after it:

$$
\text{Ini}(a,t) + L(a,t) + A(a,t) = \text{SnapshotCash}(a,d) + \bigl(L(a,t) - L(a,d)\bigr)
$$

Four consequences are worth spelling out, because they are easy to miss in the algebra:

- **The anchor is chosen per date, not once per account.** Every date asks which snapshot was in effect for *it*. Dates earlier than the first snapshot have no $d$, so they keep the plain $\text{Ini} + L + H$ formula **permanently** — adding a snapshot today never rewrites last June.
- **Cash is flat between snapshots; holdings are not.** The snapshot freezes cash until the next one, but it only declares *quantities* for the positions, and those are multiplied by the price at $t$. So the balance of a holdings-mode account still moves with the market every day — it just stops drifting with cash the snapshot didn't know about.
- **The opening balance stops mattering** for any date a snapshot covers, since $\text{Ini}$ cancels. Editing it cannot move those balances, which is why the account screen offers *Update snapshot* instead of *Correct balance* for these accounts.
- **A snapshot is only as right as its cash field.** The snapshot editor prefills the field with the app's own number, so confirming an unchanged snapshot moves nothing.

The same formula applies to every caller (single account, many accounts, net worth, evolution charts, composition). The anchor is always computed against the **unfiltered** ledger (skipping voided and pending rows, as balances do everywhere). It anchors the account itself, so it is not something a `TransactionFilterSet` can exclude. Consequence worth knowing: a balance computed under transaction filters remains an approximation for these accounts.

> **Implementation:** `AccountService._getSnapshotCashAdjustment()`, whose SQL lives in the `@visibleForTesting` `AccountService.snapshotCashAdjustmentQuery()` so the tests and the `v14.sql` backfill check the query the app really runs.

### 1.4 Several accounts at once

For a group of accounts the app sums opening balances, pooled ledger effects, snapshot anchors and holdings — the same four terms, aggregated:

$$
B(t) = \sum_{a} \text{AccountValue}(a,t)
$$

Its **relative change** between two dates gives the balance trend shown on the dashboard and in stats, as a fraction (e.g. `0.05` → +5% when displayed as a percent):

$$
\frac{B_{\mathrm{end}} - B_{\mathrm{start}}}{B_{\mathrm{start}}}
$$

A near-zero starting balance would blow this up, so the code falls back to a safe sentinel.

> **Implementation:** `AccountService.getAccountsMoney()` for the total, `AccountService.getAccountsBalanceRelativeChange()` for the trend.

---

## 2. Position cost and profit

For a holding of security $s$ in account $a$:

$$
\text{Cost}(a,s) = \text{quantity} \times \text{avgCostPrice} \qquad
\text{Market}(a,s) = \text{quantity} \times \text{price}
$$

$$
\text{UnrealizedP\&L}(a,s) = \text{Market}(a,s) - \text{Cost}(a,s)
\qquad
\text{P\&L\%} = \frac{\text{UnrealizedP\&L}}{\text{Cost}} \quad (\text{Cost} \neq 0)
$$

The average cost follows a **weighted average**, not FIFO lots. Replaying the trades of a position in date order:

- a **buy** of $q$ units at price $p$ moves the average to $\dfrac{Q \cdot A + q \cdot p}{Q + q}$;
- a **sell** reduces $Q$ and leaves $A$ untouched (the gain is realized, not re-based);
- closing the position drops $Q$ to 0, so the next buy starts a fresh cost basis.

In `holdings` tracking mode there are no trades: quantity and average cost come straight from the snapshot the user entered.

> **Implementation:** `HoldingWithSecurity` getters for the current state; `HoldingService.recomputeHolding()` for the replay; the same replay lives in SQL inside `_watchPositionValuations()` for historical dates.

---

## 3. Assets

An asset is physical, non-market property. It has a value that changes over time, no quantity and no market price, and it never lives inside an account.

### 3.1 Value at a date

For an asset $x$ (any row in the assets table), value at $t$:

$$
\text{AssetValue}(x,t) =
\begin{cases}
0 & \text{if } t \text{ is before the asset's creation date} \\
\text{LatestValuation}(x,t) & \text{if at least one valuation exists on or before } t \\
\text{InitialValue}(x) & \text{otherwise}
\end{cases}
$$

> **Implementation:** `AssetValuationService.getAssetValueAtDate()`; for "now", `getCurrentAssetValue()`.

### 3.2 Gain vs. booked initial

$$
\text{Gain}(x) = \text{AssetValue}(x,t_{\text{now}}) - \text{InitialValue}(x)
\qquad
\text{Gain\%}(x) = \frac{\text{Gain}(x)}{\text{InitialValue}(x)} \quad (\text{InitialValue}(x) \neq 0)
$$

When $\text{InitialValue}(x)=0$ the percentage is undefined and the app uses signed infinities for display edge cases. This is common in practice: an asset bought through a linked expense transaction usually has $\text{InitialValue}=0$, because the purchase already went through the ledger.

> **Implementation:** `AssetValuationService.getAssetProfit()`.

### 3.3 Net value of a financed asset

When an asset has a **linked debt** (e.g. a mortgage on a flat), its details page also shows

$$
\text{NetAssetValue}(x,t) = \text{AssetValue}(x,t) - \text{Remaining}(\text{debt}(x))
$$

converted to the asset's currency when the debt is denominated in another one. This is a **display-only** figure: net worth already subtracts every debt globally (see [Liabilities](#42-liabilities)), so this term is never applied twice.

---

## 4. Net worth

**Net worth** answers: "What is everything worth, minus what I owe?" It is computed in the **user's preferred currency**.

$$
\text{NetWorth}(t) = \text{Gross}(t) - \text{Debts}(t)
$$

> **Implementation:** `NetWorthService.getNetWorthAtDate(t)`.

### 4.1 Gross assets

**Gross assets** at $t$ (the "Assets" line in the net-worth evolution chart):

$$
\text{Gross}(t) = \underbrace{\sum_{a} \text{AccountValue}(a,t)}_{\text{cash + holdings}} \;+\; \underbrace{\sum_{x} \text{AssetValue}(x,t)}_{\text{every asset}}
$$

- The first sum runs over **every account**, using the same $\text{AccountValue}$ as [Account balance](#1-account-balance). Each investment account already includes its portfolio through $H(a,t)$.
- The second runs over **every asset**. There is no double-counting risk, because assets and securities are disjoint: an asset is never inside an account.

> **Implementation:** `NetWorthService.getGrossAssetsAtDate(t)` = `AccountService.getAccountsMoney(date: t)` + `AssetValuationService.getTotalAssetsValueAtDate(date: t)`. Optional transaction filters can be passed through for stats consistency (`TransactionFilterSet`).

### 4.2 Liabilities

**Debts** is the sum of each debt's **remaining** balance, converted to the preferred currency. Debts the user **borrowed** add to the total, while debts the user **lent** out are receivables and subtract from it:

$$
\text{Debts}(t) = \sum \text{Remaining}(\text{borrowed}) - \sum \text{Remaining}(\text{lent})
$$

Conversion uses exchange rates as of the same date $t$ used on the chart point; remaining amounts follow the live debt ledger (same behaviour as the net-worth chart).

> **Implementation:** `NetWorthService.getTotalDebtsInPreferredCurrency(exchangeRateAsOf: t)`.

### 4.3 Composition buckets

The composition pie splits **gross** into three UI buckets — account cash, account holdings, and assets — whose amounts sum to $\text{Gross}(t)$.

The cash bucket of an account is $\text{AccountValue}(a,t) - H(a,t)$, which is exactly the cash side of the [account balance](#1-account-balance) formula, snapshot anchor included.
