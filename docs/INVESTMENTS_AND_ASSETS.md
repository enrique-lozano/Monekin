# Investments, Securities & Assets

This document explains the mental model behind everything Monekin knows about **what you own**: cash accounts, investment portfolios, market instruments and physical property.

It is written for two audiences at once. The prose describes the concepts as a user experiences them; the `> Implementation` notes point developers at the tables, services and formulas behind each concept. Read the first half if you only want to understand the app, the whole thing if you are going to touch the code.

For how these numbers roll up into balances and net worth, see [BALANCE_FORMULAS.md](./BALANCE_FORMULAS.md).

---

## 1. The model in one picture

```
ACCOUNT  (type: money | investment)
│
├─ cash ledger ───────────────► transactions (E income · I expense · T transfer)
│
└─ investment accounts only
   │
   ├─ trackingMode = transactions
   │      buy/sell trades (type N) ──replayed──► HOLDING (quantity, avg cost)
   │
   └─ trackingMode = holdings
          portfolio SNAPSHOT (one per date) ──positions──► HOLDING (mirror of latest)
                                            └─cash───────► anchors the cash balance

HOLDING ──────► SECURITY  (stock | fund | crypto)
                ├─ currentPrice + priceDate     ← the latest known price
                ├─ price history                ← the price at any past date
                └─ taxonomy assignments         ← asset class, region, industry, risk

ASSET  (real estate | vehicle | precious metal | jewelry & art | other)
├─ asset valuations             ← what it was worth at a given date
└─ linked debt (optional)       ← net value = value − debt remaining
```

The single most important idea: **assets and securities are different things**. Anything with a market price that you own units of is a *security*; anything physical you own one of is an *asset*. They have separate tables, separate pages and separate maths.

---

## 2. The concepts

| Concept | In plain words | Table |
| --- | --- | --- |
| **Account** | Where your money lives | `accounts` |
| **Tracking mode** | How an investment account knows what it holds | `accounts.trackingMode` |
| **Security** | A tradable instrument: a stock, a fund/ETF, a crypto coin | `securities` |
| **Price history** | What a security was worth on a given day | `securityPrices` |
| **Holding** | *You* own N units of a security in a given account | `holdings` |
| **Trade** | A buy or a sell that moved cash and changed a holding | `transactions` (type `N`) |
| **Snapshot** | A photo of an account's whole state on a date: its positions and its cash | `accountSnapshots` + `holdingSnapshots` |
| **Asset** | A physical thing you own: a flat, a car, gold | `assets` |
| **Valuation** | What an asset was worth on a given day | `assetValuations` |
| **Classification** | How a security is labelled for portfolio reporting | `taxonomies`, `taxonomyCategories`, `securityTaxonomyAssignments` |

### 2.1 Account

Two types: **money** (cash only) and **investment** (cash *plus* positions in securities). A money account can additionally behave as a savings account, where money only moves in and out through transfers.

An investment account is not a separate world: it still has a normal cash ledger with income, expenses and transfers. The portfolio sits on top of that cash.

> **Implementation:** `accounts.type` (`money` | `investment`), `accounts.isSaving`. An account's total value is its cash (opening balance + cash ledger, or whatever its latest snapshot declares — see [Portfolio snapshot](#27-portfolio-snapshot)) plus its holdings market value. `AccountService.getAccountMoney()` / `getAccountCash()`.

### 2.2 Tracking mode

Only meaningful for investment accounts, and it answers one question: *where does the app get your positions from?*

- **Transactions mode** — you record every buy and sell. The app replays them in order and derives how many units you hold and what you paid on average. This is the accurate, detailed option: it knows your cost basis, your realized cash flow and your full trade history.
- **Holdings mode** — you never record trades. Instead you periodically enter a **snapshot**: "on this date my account was X units of A, Y units of B bought at these average prices, and this much cash". This is the low-effort option, and the right one when your broker only shows you a current position and you don't want to reconstruct years of history.

The difference runs deeper than where positions come from. In transactions mode every number is *derived* from flows you recorded, so the ledger is the authority. In holdings mode you *state* the result, so the snapshot is the authority — including for cash. Income, expenses and transfers keep working in holdings mode, and keep their history: they accumulate on top of the last snapshot.

The two modes are mutually exclusive per account, and you can switch. Nothing is deleted either way: converting carries your current positions (and cash) over to whatever the new mode reads from, and your transactions and snapshots are both preserved even while only one of them decides the balance.

> **Implementation:** `AccountTrackingMode` (`transactions` | `holdings`) in `lib/core/models/account/account.dart`. Switching is `HoldingService.convertTrackingMode()`, which either writes a snapshot dated today (with the account's current cash, so the balance doesn't move) or creates zero-cash anchor buys for positions with no trade history. It does not save the account row; the caller does that.

### 2.3 Security

A stock, fund/ETF or crypto asset. A security is a **shared, global definition**, not a position: `AAPL` exists once, with one name, one ticker, one quote currency and one price, and any number of accounts can hold it.

It carries the latest known price (`currentPrice` + `priceDate`) so that lists and totals stay cheap to compute, plus optional notes, icon and colour.

> **Implementation:** `securities` table, `SecurityInDB`, `SecurityService`. `SecurityType` is `stock | fund | crypto`.

### 2.4 Price history

Every price you record for a security is kept as a dated observation, which is what makes the price chart and every historical valuation possible. The most recent observation is mirrored into `securities.currentPrice`/`priceDate`.

Prices are entered manually (Monekin is offline-first), either one at a time or by importing a CSV. Editing history retroactively changes every past chart and statistic that depends on it — that is the point.

> **Implementation:** `securityPrices`. The price used at date *t* is the latest row with `date <= t`, falling back to `securities.currentPrice`.

### 2.5 Holding

The join between an account and a security: **how many units, and at what weighted-average cost**. There is at most one holding row per (account, security) pair.

The average cost is what "how am I doing?" is measured against:

$$
\text{Market value} = \text{quantity} \times \text{price} \qquad
\text{Cost basis} = \text{quantity} \times \text{avgCost}
$$

$$
\text{Unrealized P\&L} = \text{Market value} - \text{Cost basis}
$$

> **Implementation:** `holdings` (unique on `accountID` + `securityID`), `HoldingWithSecurity` for the derived getters. All monetary getters are in the **security's** currency; convert at the call site.

### 2.6 Trade

A buy or a sell, stored as a transaction of type **`N`** (investment). It is the cash leg of the operation *and* the record of the position change: it stores `quantity` (positive when buying, negative when selling) and `pricePerUnit` alongside the cash `value`.

Trades are deliberately excluded from income/expense statistics: buying shares is not an expense, it is moving money from one form to another.

Cost basis follows a **weighted average**, not FIFO lots: buying moves the average, selling only reduces the quantity and leaves the average untouched. Closing a position entirely resets it, so buying back later starts a fresh cost basis.

> **Implementation:** `transactions.type = 'N'` with `securityID` set, `categoryID`/`receivingAccountID` null (enforced by a `CHECK`). `HoldingService.buy()` / `sell()` write the trade and call `recomputeHolding()`, which replays every trade in date order rather than patching the stored numbers.

### 2.7 Portfolio snapshot

A snapshot is **the complete state of one account on one date** — not a single position. This matters: when valuing the account at a date, the app takes the most recent snapshot on or before that date and treats it as the whole truth. A security missing from that snapshot is considered *not held*, which is how you record having sold something: you simply leave it out of the next snapshot.

That truth covers the **cash** too. A snapshot says how much uninvested money the account held that day, and from then on that figure is the cash balance. Transactions dated later still count on top of it, so interest, dividends, fees and transfers keep behaving normally.

Two limits on how far that truth reaches. It only settles the **cash**: the positions it declares are quantities, still priced at whatever date you ask about, so the account's value keeps moving with the market between snapshots. And it only reaches **forward**: dates earlier than your first snapshot are valued from the ledger alone, for good, so snapshotting today never rewrites last year.

One snapshot per account per date. A snapshot with no positions is legal and means "the portfolio was empty that day" (it can still declare cash).

> **Implementation:** `accountSnapshots` (unique on `accountID` + `date`, with a `cash` column in the account currency) and child rows in `holdingSnapshots`. `HoldingService.saveAccountSnapshot()` replaces any snapshot on that date and then calls `syncHoldingsFromLatestSnapshot()`, which rebuilds the `holdings` rows so the rest of the app keeps reading a single, uniform "current position" source. The cash side is applied by `AccountService._getSnapshotCashAdjustment()` — see [Snapshot anchor](./BALANCE_FORMULAS.md#13-snapshot-anchor) in BALANCE_FORMULAS.md.

### 2.8 Asset

Physical, non-market property: real estate, vehicles, precious metals, jewelry & art, other. You own *the thing*, not units of it, so an asset has no quantity and no ticker — just a value that changes over time.

An asset stands on its own: it does not live inside an account, because your flat is not part of your bank balance. It is added directly to net worth.

It can optionally have a **linked debt** — attach the mortgage to the flat, and the asset page shows its *net* value (value − outstanding debt). That figure is display-only; net worth already subtracts every debt globally.

Buying an asset is usually recorded as a normal expense transaction linked to it, which is why an asset's `initialValue` is often 0: the money already left through the ledger.

> **Implementation:** `assets`, `AssetType` (`real_estate | vehicle | precious_metal | jewelry_art | other`), `AssetService`, `AssetValuationService`. The enum's `databaseValue` is snake_case and is enforced by a `CHECK` — the Dart name (`jewelryArt`) is *not* what goes in the column.

### 2.9 Valuation

The asset equivalent of a price observation: what the asset was worth on a date. The value at date *t* is the latest valuation on or before *t*, or the initial value if there is none, or 0 before the asset existed.

> **Implementation:** `assetValuations`, unique on `assetId` + `date`. See [Assets](./BALANCE_FORMULAS.md#3-assets) in BALANCE_FORMULAS.md.

### 2.10 Classification (taxonomies)

So that "what is my portfolio made of?" can be answered by something other than the instrument name, securities can be labelled along **taxonomies**. Four ship built-in (seeded, marked `isSystem`, but fully editable):

| Taxonomy | Categories | Selection |
| --- | --- | --- |
| **Asset Classes** | Cash, Equity, Fixed Income, Real Estate, Commodities, Alternatives, Digital Assets | multiple, weighted |
| **Regions** | 5 continents with sub-regions (Northern Europe, Latin America, Eastern Asia…) | multiple, weighted |
| **Industries** | The 11 GICS sectors | multiple, weighted |
| **Risk Category** | Unknown, Low, Medium, High | single |

Weighted assignment is what makes a global fund honest: a world ETF can be 60% Northern America and 40% Europe instead of being forced into one bucket. Weights are stored in **basis points** (10 000 = 100%). Categories can nest one level (Europe → Southern Europe) and each carries a colour used consistently in charts and pickers.

> **Implementation:** `taxonomies`, `taxonomyCategories` (self-referencing `parentID`), `securityTaxonomyAssignments` (unique on security + taxonomy + category, `weight` 0..10000). Seeded from `assets/sql/initial_taxonomies.json` by `TaxonomyService.ensureSeeded()`, which runs after a migration **and** after a database import, so restoring an old backup also gets the taxonomies.

---

## 3. Which one do I use?

| You own… | Model it as | Why |
| --- | --- | --- |
| Shares of Apple | Security + holding | It has a price per unit and you own a quantity |
| An accumulating world ETF | Security + holding | Same, and it can be split across regions/industries |
| Bitcoin | Security + holding | Same |
| Your flat | Asset (real estate) | One indivisible thing with a periodic appraisal |
| Your car | Asset (vehicle) | Same |
| A gold bar | Asset (precious metal) | You are tracking *this* bar, not a quantity of a quoted instrument |
| A savings deposit | Money account (savings) | It is cash that earns interest, not an instrument |

Rule of thumb: if the question "how many do you have?" makes sense, it's a security.

---

## 4. Valuation is time-aware

Everything above is evaluated **as of a date**, not just "now". Asking what the portfolio was worth last March reconstructs both sides of the multiplication:

- **The price at that date** — the latest price observation on or before it.
- **The quantity at that date** — replayed trades up to that date (transactions mode), or the position in the most recent snapshot on or before it (holdings mode).

The universe of positions comes from your *activity*, not from the current `holdings` table, so a security you sold last year still contributes to the chart on the dates you actually held it.

> **Implementation:** `HoldingService._watchPositionValuations()` — one recursive SQL query that builds the position universe, replays the weighted-average cost, and joins the price at the date. Everything time-aware (account value, portfolio composition, net worth history) goes through it. `getHoldingsMarketValue()` and `getHoldingValuationsAtDate()` are the public entry points.

---

## 5. Typical flows

**Recording a purchase (transactions mode).** Open the account → *Buy* → pick or create a security → enter units and price per unit. The app writes an `N` transaction for the cash and recomputes the holding. Selling is the mirror image; selling everything leaves a holding of zero units.

**Keeping a portfolio up to date (holdings mode).** Open the account → *Snapshots* → *New*. Enter the cash the account holds that day and every position, with its quantity and average cost. The cash field arrives prefilled with what the app believes you have, so confirming an unchanged snapshot never moves your balance; correct it when your broker says otherwise. Anything you leave out of the positions is treated as sold. Repeat whenever you feel like it: the app values every day in between using the last snapshot before it.

**Switching modes.** Change the tracking mode on the account form. Positions are carried over — to a snapshot dated today (carrying the current cash with them), or to anchor buys that create the position without moving cash.

**Buying a flat with a mortgage.** Create the debt, create the asset, link them, and record the down payment as a normal expense. The asset page then shows value, outstanding debt and net value; net worth counts the asset once and subtracts the debt.

**Updating prices.** Security or asset details → the history card → add, edit or delete an observation. Lists load the 10 most recent entries with a *see more* button, so a security with hundreds of prices still opens instantly.

---

## 6. Online market data

When creating a security you can type a name and, if you are online, get real instruments to pick from. Choosing one fills in the name, ticker, type, currency and current price, and takes a first guess at the classification (asset class from the instrument type, industry from the sector, region from the exchange). Every guess is editable — it is a shortcut, not a source of truth.

Logos are fetched by ticker and cached, falling back to a generated badge with the ticker letters when there isn't one.

This does not compromise the offline-first promise: requests only happen while you are actively typing in that field, they time out quickly, and every failure degrades to "no results" rather than an error. Nothing syncs, nothing is uploaded, and no financial data ever leaves the device.

> **Implementation:** `lib/core/services/market_data/`. `MarketDataProvider` is the abstraction (search / quote / logo), `YahooFinanceProvider` the only implementation, `MarketDataService` the singleton entry point plus the mapping to `SecurityType` and taxonomy ids. It keeps an in-memory negative cache of tickers with no logo so they aren't re-requested every rebuild. `getPriceHistory()` is intentionally unimplemented behind `supportsPriceHistory` — it is the hook for a future price backfill.

---

## 7. Reference (dev)

| Table | Dart | Service |
| --- | --- | --- |
| `accounts` | `AccountInDB` / `Account` | `AccountService` |
| `securities` | `SecurityInDB` | `SecurityService` |
| `securityPrices` | `SecurityPriceInDB` | `SecurityService` |
| `holdings` | `HoldingInDB` / `HoldingWithSecurity` | `HoldingService` |
| `accountSnapshots` + `holdingSnapshots` | `AccountSnapshotWithPositions`, `SnapshotPosition` | `HoldingService` |
| `assets` | `AssetInDB` / `Asset` | `AssetService` |
| `assetValuations` | `AssetValuationInDB` | `AssetValuationService` |
| `taxonomies`, `taxonomyCategories`, `securityTaxonomyAssignments` | `TaxonomyInDB`, `TaxonomyCategoryInDB`, `SecurityTaxonomyAssignmentInDB` | `TaxonomyService` |
| `transactions` (type `N`) | `TransactionInDB` | `TransactionService`, `HoldingService` |

### Invariants worth knowing

- An `N` transaction must have an `assetID` or a `securityID`, and must have no category, no receiving account and no destination value. A non-`N` transaction must have exactly one of category / receiving account.
- `holdings` is unique per (account, security); `accountSnapshots` is unique per (account, date); `holdingSnapshots` is unique per (snapshot, security).
- Holdings are always **derived**, never authoritative: transactions mode rebuilds them from trades, holdings mode mirrors the latest snapshot. Never patch a holding in place — call `recomputeHolding()` or `syncHoldingsFromLatestSnapshot()`.
- Monetary values on holding/snapshot models are in the **security's** currency. Conversion happens in the services that aggregate them, using the exchange rate as of the same date. The one exception is `accountSnapshots.cash`, which is in the **account's** currency — it is cash, not an instrument.
- A snapshot's cash is authoritative from its date on, so never write a snapshot without deciding what it should say about cash: `saveAccountSnapshot()` requires it, and passing the account's current cash (`AccountService.getAccountCash()`) is what leaves the balance untouched.
- Assets and accounts are disjoint: an asset is never inside an account, so net worth adds every asset on top of every account balance without any double-counting rule to remember.
- Enum columns store `databaseValue`, not the Dart identifier. Renaming an enum value is a migration.

### Where this came from (schema v13 & v14)

**v14** gave `accountSnapshots` its `cash` column. Until then a holdings-mode account declared its positions but took its cash from the ledger, so entering a position added market value that nothing had paid for and the balance jumped on that date and every later one. Every existing snapshot was backfilled with the ledger cash of its account on the snapshot date, which is exactly what the app computed before, so the upgrade moves no balance and deletes nothing.

Before v13, stocks and funds were `assets` with an `assetType` of `stocks`/`funds`/`crypto` linked to an account through `assets.linkedAccountID`. v13 split that in two: those rows became a **security** plus a **holding**, their valuations became price history, and their investment transactions became security trades. Migrated positions get a synthetic anchor trade labelled *"Opening position"*, and their average cost is seeded from the security's price, so a freshly migrated portfolio starts at zero P&L instead of showing a fictional gain. With the split done, `linkedAccountID` was dropped: holdings are now the only way something lives inside an account.

The migration is destructive and one-way; a backup is written before it runs. See `assets/sql/migrations/README.md` for the conventions these files must follow.

---

## 8. Glossary

| Term | Meaning |
| --- | --- |
| **Cost basis** | What you actually paid for the units you still hold (`quantity × average cost`) |
| **Market value** | What those units are worth today (`quantity × current price`) |
| **Unrealized P&L** | Market value − cost basis: the gain you'd book if you sold now |
| **Weighted-average cost** | One blended purchase price per position, instead of tracking individual lots (FIFO) |
| **Snapshot** | The full state of an account on a date: its positions and its cash |
| **Anchor trade** | A synthetic zero-cash buy that recreates a position with no trade history |
| **Basis points** | Hundredths of a percent; taxonomy weights use them (10 000 = 100%) |
| **Taxonomy** | A classification dimension (asset class, region, industry, risk) |

---

## 9. Related documents

- [BALANCE_FORMULAS.md](./BALANCE_FORMULAS.md) — how account balances, position P&L and net worth are computed.
- `assets/sql/migrations/README.md` — writing database migrations.
- `AGENTS.md` — architecture, conventions and code-generation workflow.
