# Balance Formulas

This document describes how account balances and net worth are computed in Monekin from a financial perspective.

---

## 1. Normal and Saving Accounts

The balance of a normal or saving account at a given date $t$ is:

$$
B(t) = B_0 + \sum I_i - \sum E_j + \sum T^{in}_k - \sum T^{out}_l
$$

Where:

| Symbol | Meaning |
| --- | --- |
| $B_0$ | **Opening balance** — the initial value of the account at the time it was created. Only counted if the account's opening date $\leq t$. |
| $\sum I_i$ | **Total income** — all confirmed income transactions dated on or before $t$. |
| $\sum E_j$ | **Total expenses** — all confirmed expense transactions dated on or before $t$. |
| $\sum T^{in}_k$ | **Incoming transfers** — the value received from transfers into this account, dated on or before $t$. The received amount may differ from the sent amount due to currency conversion. |
| $\sum T^{out}_l$ | **Outgoing transfers** — the value sent from this account to other accounts, dated on or before $t$. |

**Notes:**

- Pending and voided transactions are excluded from all sums.
- When computing balances in a common currency, exchange rates are applied at the transaction date.
- If the account was opened after date $t$, its balance is considered $0$.

> **Implementation:** `AccountService.getAccountsMoney()`

---

## 2. Investment Accounts

Investment accounts model assets like stocks, funds, or other holdings whose market value may fluctuate independently of cash flows.

### 2.1 Portfolio Value (Balance)

The balance of an investment account is its **portfolio value**:

$$
V =
\begin{cases}
\text{latest valuation} & \text{if at least one valuation exists} \\
C_{invested} & \text{otherwise (fallback)}
\end{cases}
$$

A **valuation** is a user-recorded snapshot of the account's market value at a point in time. If no valuation has been recorded, the balance falls back to the invested capital.

### 2.2 Invested Capital

Invested capital represents the net amount of money the user has put into the account:

$$
C_{invested} = B_0 + \sum T^{in}_k - \sum T^{out}_l
$$

Where:

| Symbol | Meaning |
| --- | --- |
| $B_0$ | **Opening balance** at account creation. |
| $\sum T^{in}_k$ | **Incoming transfers** — money transferred into the investment account. |
| $\sum T^{out}_l$ | **Outgoing transfers** — money withdrawn from the investment account. |

Only confirmed (non-pending, non-voided) transfers are included.

### 2.3 Profit & Return

$$
\text{Profit} = V - C_{invested}
$$

$$
\text{Return (\%)} = \frac{V - C_{invested}}{C_{invested}} \times 100
$$

A positive profit means the portfolio has gained value beyond what was invested; a negative value indicates a loss.

> **Implementation:** `InvestmentService.getPortfolioValue()`, `InvestmentService.getInvestedCapital()`

---

## 3. Stand-alone Assets

Assets (e.g., real estate, vehicles, collectibles) are tracked independently from accounts. Their current value is:

$$
V_{asset} =
\begin{cases}
\text{latest valuation} & \text{if at least one valuation exists} \\
V_{initial} & \text{otherwise}
\end{cases}
$$

Where $V_{initial}$ is the value assigned to the asset when it was first created.

> **Implementation:** `InvestmentService.getAssetValue()`

---

## 4. Net Worth

Net worth aggregates all the user's financial positions into a single figure, expressed in the user's preferred currency:

$$
W = \underbrace{\sum B_a(t)}_{\text{account balances}} + \underbrace{\sum V_b}_{\text{investment portfolios}} + \underbrace{\sum V_c}_{\text{assets}}
$$

Where:

| Component | Included if |
| --- | --- |
| $B_a(t)$ — Balance of each normal/saving account | Account is open and marked *include in net worth* |
| $V_b$ — Portfolio value of each investment account | Account is open and marked *include in net worth* |
| $V_c$ — Value of each stand-alone asset | Asset is marked *include in net worth* |

All values are converted to the user's preferred currency before summing.
