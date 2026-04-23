# Balance Formulas

This document describes how account balances and net worth are computed in Monekin from a financial perspective.

---

## 1. Accounts

How to compute the balance of an account. In financial terms, the **balance** (Spanish: *saldo*) is the net amount available in an account after all transactions.

### 1.1 Normal and Saving Accounts

The balance of account $a$ at a given date $t$ is:

$$
\text{AccountValue}(a, t) = \text{InitialValue}(a) + \sum \text{Income}(a, t) - \sum \text{Expense}(a, t) + \sum \text{TransfersIn}(a, t) - \sum \text{TransfersOut}(a, t)
$$

Where:

| Term | Meaning |
| --- | --- |
| $\text{InitialValue}(a)$ | **Opening balance** — the value of the account at the time it was created. |
| $\sum \text{Income}(a, t)$ | **Total income** — all confirmed income transactions in account $a$ dated on or before $t$. |
| $\sum \text{Expense}(a, t)$ | **Total expenses** — all confirmed expense transactions in account $a$ dated on or before $t$. |
| $\sum \text{TransfersIn}(a, t)$ | **Incoming transfers** — the value received from transfers into account $a$, dated on or before $t$. The received amount may differ from the sent amount due to currency conversion. |
| $\sum \text{TransfersOut}(a, t)$ | **Outgoing transfers** — the value sent from account $a$ to other accounts, dated on or before $t$. |

**Notes:**

- Pending and voided transactions are excluded from all sums.
- When computing balances in a common currency, the result is converted using the exchange rate at time $t$.
- If the account was opened after date $t$, its balance is $0$.

> **Implementation:** `AccountService.getAccountsMoney()`

### 1.2 Investment Accounts

The balance of an investment account equals its **portfolio value** — the current market worth of the holdings:

$$
\text{AccountValue}(a) =
\begin{cases}
\text{LatestValuation}(a) & \text{if at least one valuation exists} \\
\text{InvestedCapital}(a) & \text{otherwise (fallback)}
\end{cases}
$$

A **valuation** is a user-recorded snapshot of the account's market value at a point in time. If no valuation exists, the balance falls back to the invested capital.

> **Implementation:** `InvestmentService.getInvestmentAccountValue()`

#### Invested Capital

Invested capital represents the net amount of money the user has put into the account:

$$
\text{InvestedCapital}(a) = \text{InitialValue}(a) + \sum \text{TransfersIn}(a) - \sum \text{TransfersOut}(a)
$$

Where:

| Term | Meaning |
| --- | --- |
| $\text{InitialValue}(a)$ | **Opening balance** at account creation. |
| $\sum \text{TransfersIn}(a)$ | **Incoming transfers** — money transferred into the investment account. |
| $\sum \text{TransfersOut}(a)$ | **Outgoing transfers** — money withdrawn from the investment account. |

Only confirmed (non-pending, non-voided) transfers are included.

> **Implementation:** `InvestmentService.getInvestedCapital()`

#### Profit & Return

$$
\text{Profit}(a) = \text{PortfolioValue}(a) - \text{InvestedCapital}(a)
$$

$$
\text{Return}(a) = \frac{\text{PortfolioValue}(a) - \text{InvestedCapital}(a)}{\text{InvestedCapital}(a)} \times 100
$$

A positive profit means the portfolio has gained value beyond what was invested; a negative value indicates a loss.

> **Implementation:** `InvestmentService.getInvestmentProfit()`

---

## 2. Assets

Assets (e.g., real estate, vehicles, collectibles) are tracked independently from accounts. Unlike accounts, they have no transaction ledger — their worth is determined solely by valuations. Their current value is:

$$
\text{AssetValue}(s) =
\begin{cases}
\text{LatestValuation}(s) & \text{if at least one valuation exists} \\
\text{InitialValue}(s) & \text{otherwise}
\end{cases}
$$

Where $\text{InitialValue}(s)$ is the value assigned to the asset when it was first created.

> **Implementation:** `InvestmentService.getAssetValue()`

---

## 3. Net Worth

Net worth aggregates all the user's financial positions into a single figure, expressed in the user's preferred currency:

$$
\text{NetWorth}(t) = \sum_{a \in A_c} \text{AccountValue}(a, t) \;+\; \sum_{a \in A_i} \text{AccountValue}(a, t) \;+\; \sum_{s \in S} \text{AssetValue}(s, t)
$$

Where:

| Set | Description | Included if |
| --- | --- | --- |
| $A_c$ | Normal and saving accounts | Account is open and marked *include in net worth* |
| $A_i$ | Investment accounts | Account is open and marked *include in net worth* |
| $S$ | Stand-alone assets | Asset is marked *include in net worth* |

- $\text{AccountValue}(a, t)$ refers to the account balance as defined in sections 1.1 and 1.2.
- $\text{AssetValue}(s, t)$ refers to the asset value as defined in section 2.
- All values are converted to the user's preferred currency before summing.
