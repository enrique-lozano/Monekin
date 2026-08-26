# Balance Formulas

This document describes how account balances, portfolio values, asset values, and **net worth** are computed in Monekin.

For the concepts behind these numbers (securities, holdings, tracking modes, snapshots), see [INVESTMENTS_AND_ASSETS.md](./INVESTMENTS_AND_ASSETS.md).

---

## 1. Account balance (single account)

Section 1 defines **one account’s** balance at date $t$, denoted $\text{AccountValue}(a,t)$. Net worth (section 5) **aggregates** these same quantities across accounts; it is not a different kind of balance.

For every account $a$ (money, saving, or investment):

$$
\text{AccountValue}(a,t) = \text{Ini}(a,t) + L(a,t) + H(a,t)
$$

| Term              | Meaning                                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------------------------ |
| $\text{Ini}(a,t)$ | **Opening balance** at account creation, counted only if the account exists on or before $t$; otherwise $0$. |
| $L(a,t)$          | **Cash ledger net** — effect of all counted transactions on account $a$ with date $\leq t$.                   |
| $H(a,t)$          | **Holdings** — market value of the securities held in account $a$ at $t$. For cash accounts, $H(a,t)=0$.      |

Assets are **not** part of any account: physical property stands on its own and is added directly to net worth (section 5).

### 1.1 Cash ledger net $L(a,t)$

Transactions use **signed** stored `value` (expenses negative, income positive in normal use). **Transfers** net outflows from the origin account and inflows to the destination (using `valueInDestiny` when applicable). **Investment-type** rows (`N`) are the **cash leg** of buys and sells: buying shares removes cash from the ledger and adds it to $H$, so the account total doesn't jump. Pending / voided rows are excluded from statistics in the usual way. Amounts can be converted to a reference currency using rates as of $t$.

> **Implementation:** `TransactionService.getTransactionsValueBalance()` with filters scoped to account $a$ and `maxDate` $t$.

### 1.2 Holdings market value $H(a,t)$

$$
H(a,t) = \sum_{s \,\in\, \text{Pos}(a,t)} q(a,s,t) \times p(s,t)
$$

Every factor is resolved **as of $t$**, never from today's state:

- $\text{Pos}(a,t)$ — every security the account has ever held, taken from its activity rather than from the current `holdings` rows, so a position sold before $t$ still counts on earlier dates.
- $q(a,s,t)$ — units held at $t$. In `transactions` tracking mode, the trades up to $t$ replayed in order. In `holdings` mode, the quantity in the most recent snapshot on or before $t$ (0 when the security is absent from it, which is how a sale is expressed).
- $p(s,t)$ — the latest price observation on or before $t$, falling back to the security's `currentPrice`.

Each position is summed in its security's own currency and converted from there, so an account holding instruments quoted in different currencies is valued correctly.

> **Implementation:** `HoldingService.getHoldingsMarketValue()`, built on the single time-aware query `HoldingService._watchPositionValuations()`.

Rounding in the account’s currency applies when not converting. For several accounts at once, the app sums opening balances, pooled ledger effects, and holdings the same way.

> **Implementation:** `AccountService.getAccountMoney(account: …)`; `AccountService.getAccountsMoney(…)` for many accounts.

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

## 3. Asset market value

For an **asset** $s$ (any row in the assets table), value at $t$:

$$
\text{AssetValue}(s,t) =
\begin{cases}
0 & \text{if } t \text{ is before the asset’s creation date} \\
\text{LatestValuation}(s,t) & \text{if at least one valuation exists on or before } t \\
\text{InitialValue}(s) & \text{otherwise}
\end{cases}
$$

> **Implementation:** `AssetValuationService.getAssetValueAtDate()`; “now”: `getCurrentAssetValue()`.

### 3.1 Net value of a financed asset

When an asset has a **linked debt** (e.g. a mortgage on a flat), its details page also shows

$$
\text{NetAssetValue}(s,t) = \text{AssetValue}(s,t) - \text{Remaining}(\text{debt}(s))
$$

converted to the asset's currency when the debt is denominated in another one. This is a **display-only** figure: net worth already subtracts every debt globally (section 5.2), so this term is never applied twice.

---

## 4. Asset gain vs. booked initial

$$
\text{Gain}(s) = \text{AssetValue}(s,t_{\text{now}}) - \text{InitialValue}(s)
$$

$$
\text{Gain\%}(s) = \frac{\text{Gain}(s)}{\text{InitialValue}(s)} \quad (\text{when } \text{InitialValue}(s) \neq 0)
$$

When $\text{InitialValue}(s)=0$, the percentage is undefined; the app uses signed infinities for display edge cases. Note that an asset bought through a linked expense transaction usually has $\text{InitialValue}=0$, because the purchase already went through the ledger.

> **Implementation:** `AssetValuationService.getAssetProfit()`.

---

## 5. Net worth

**Net worth** answers: “What is everything worth, minus what I owe?” It is computed in the **user’s preferred currency**.

It is **not** a repeat of section 1: section 1 defines $\text{AccountValue}(a,t)$ for **each** account $a$. Here we **add** those balances across accounts, **add** every asset, then **subtract** debts.

### 5.1 Gross assets

**Gross assets** at $t$ (the “Assets” line in the net-worth evolution chart):

$$
\text{Gross}(t) = \underbrace{\sum_{a \in A} \text{AccountValue}(a,t)}_{\text{cash + holdings, same } \text{AccountValue} \text{ as §1}} \;+\; \underbrace{\sum_{s \in S} \text{AssetValue}(s,t)}_{\text{every asset}}
$$

- $A$: every account. Each investment account already includes its portfolio inside $\text{AccountValue}$ via $H(a,t)$.
- $S$: every asset. There is no double-counting risk, because assets and securities are disjoint: an asset is never inside an account.

> **Implementation:** `NetWorthService.getGrossAssetsAtDate(t)` = `AccountService.getAccountsMoney(date: t)` + `AssetValuationService.getTotalAssetsValueAtDate(date: t)`.

Optional transaction filters can be passed through for stats consistency (`TransactionFilterSet`).

### 5.2 Liabilities (debts)

**Debts** is the sum of each debt’s **remaining** balance, converted to the preferred currency: debts the user **borrowed** add to the total, while debts the user **lent** out are receivables and subtract from it ($\text{Debts}(t) = \sum \text{Remaining}(\text{borrowed}) - \sum \text{Remaining}(\text{lent})$). Conversion uses exchange rates as of the same date $t$ used on the chart point; remaining amounts follow the live debt ledger (same behaviour as the net-worth chart).

> **Implementation:** `NetWorthService.getTotalDebtsInPreferredCurrency(exchangeRateAsOf: t)`.

### 5.3 Net worth

$$
\text{NetWorth}(t) = \text{Gross}(t) - \text{Debts}(t)
$$

> **Implementation:** `NetWorthService.getNetWorthAtDate(t)`.

The composition pie splits **gross** into three UI buckets — account cash, account holdings, and assets — whose amounts sum to $\text{Gross}(t)$. The cash bucket of an account is $\text{AccountValue}(a,t) - H(a,t)$.

### 5.4 Period balance trend (dashboard / stats)

Relative change in **combined** balance for selected accounts between two dates, as a fraction (e.g. `0.05` → +5% when shown as a percent):

$$
\frac{B_{\mathrm{end}} - B_{\mathrm{start}}}{B_{\mathrm{start}}}
$$

where $B$ is the same total as `getAccountsMoney` for those accounts. Near-zero start uses a safe sentinel in code.

> **Implementation:** `AccountService.getAccountsBalanceRelativeChange()`.
