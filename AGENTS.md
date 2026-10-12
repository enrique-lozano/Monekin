# AGENTS.md

AI agent guide for the **Monekin** repository — a 100% open-source, offline-first personal finance app built with Flutter. Covers behavioral rules, architecture, and common task playbooks.

---

## Skills & Precedence

This repo bundles reusable Agent Skills under `.agents/skills/` (generic Flutter/Dart workflows plus a `frontend-design` skill). They are helpful defaults, **but this `AGENTS.md` and the actual patterns already in the codebase always win.** When a skill's advice conflicts with the project, follow the project.

Known conflicts to be aware of (do it the Monekin way, not the generic way):

- **Serialization**: use `json_serializable`/`freezed` codegen + Drift — not hand-written `fromJson`/`toJson` or `dart:convert` mapping.
- **i18n**: use `slang` (`t.*`, JSON sources → `dart run slang`) — not `intl`/`flutter_localizations` `gen-l10n`/`.arb`.
- **Routing**: use the existing custom `Navigator` + `lib/core/routes/RouteUtils` — not `go_router` or other routing packages.
- **Architecture/state**: follow the existing feature-folder + singleton-service + Drift-stream approach (see "Code Layout" and "Service pattern") — do **not** introduce MVVM ViewModels, a Repository layer, or a `data/domain/ui` restructure.
- **Data source**: Monekin is offline-first (local SQLite). Ignore skill guidance that assumes REST/HTTP APIs unless a prompt explicitly adds networking.
- **Dart features**: target the SDK range in `pubspec.yaml` (`>=3.10.1`). Don't use features that require a newer SDK (e.g. primary constructors).

If a skill would be genuinely useful but conflicts on details, adapt its intent to Monekin's conventions rather than importing its boilerplate wholesale.

---

## Behavioral Guidelines

**These come first because they prevent the most mistakes.**

### 1. Think Before Coding

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them—don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.

### 2. Simplicity First

- No features beyond what was asked.
- No abstractions for single-use code.
- No error handling for impossible scenarios.
- Don’t comment the obvious. Keep comments short; skip them on simple code.
- If 200 lines could be 50, rewrite it. _"Don't walk away from complexity, run!"_

### 3. Surgical Changes

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated issues, mention them—don't fix them.
- Remove only what YOUR changes made unused.

### 4. Goal-Driven Execution

- Transform tasks into verifiable goals.
- For multi-step tasks, state a brief plan with verification steps.
- Unverified work is incomplete work.

### 5. Output Precision

- Lead with findings, not process descriptions.
- Use structured formats (lists, tables, code blocks).
- Include absolute file paths—never relative.

---

## Overview

- **Framework**: Flutter (SDK pinned in `pubspec.yaml`; Dart `>=3.10.1 <4.0.0`)
- **State**: Lightweight — `provider`, `rxdart` streams, singleton services, and `StatefulWidget`/`setState`. No heavy state-management framework.
- **Persistence**: Local **SQLite** via [`drift`](https://drift.simonbinder.eu/) (offline-first, no backend/cloud).
- **i18n**: [`slang`](https://github.com/slang-i18n/slang) — JSON sources compiled to Dart. Access via the global `t` object.
- **Charts**: `fl_chart`. **Icons/SVG**: `flutter_svg`.
- **Target platforms**: Android and Windows are the shipping targets (Google Play + Microsoft Store). A web DB connection also exists (`drift` WASM). Keep shared code platform-agnostic.

## Code Layout

```
lib/
├── main.dart                 # App entry point, MaterialApp, theming, locale bootstrap
├── app/                      # Feature modules (UI + feature-local logic)
│   ├── accounts/             # Accounts + asset valuations
│   ├── assets/               # Investment assets
│   ├── budgets/              # Budgets
│   ├── categories/           # Categories + subcategories, icon/color pickers
│   ├── currencies/           # Currency manager, exchange rates
│   ├── debts/                # Debts (loans/borrows)
│   ├── goals/                # Savings goals
│   ├── home/                 # Dashboard
│   ├── layout/               # Navigation shell, sidebar, bottom bar, window bar
│   ├── onboarding/           # Intro / onboarding flow
│   ├── settings/             # Settings, backup/restore, purchases, about
│   ├── stats/                # Statistics, net worth, distributions, charts
│   ├── tags/                 # Tags
│   └── transactions/         # Transaction list, form, details, recurrency
├── core/
│   ├── database/
│   │   ├── app_db.dart       # Drift DB definition (@DriftDatabase, singleton `AppDB.instance`)
│   │   ├── app_db.g.dart     # GENERATED — never edit by hand
│   │   ├── connection/       # native.dart / web.dart / connection.dart (platform DB open)
│   │   ├── services/         # Data-access services, one per domain (singleton `.instance`)
│   │   ├── backup/           # Backup / restore
│   │   ├── sql/              # .drift files (tables, queries), initial seed
│   │   └── utils/            # Converters, enums, seeders
│   ├── models/               # Domain models (freezed / copy_with / json_serializable)
│   ├── presentation/         # SHARED, reusable UI
│   │   ├── widgets/          # Cross-feature widgets
│   │   ├── theme.dart        # getThemeData(...)
│   │   ├── styles/           # Borders, button styles
│   │   ├── responsive/       # Breakpoints, responsive row/column
│   │   ├── animations/       # Reusable animations
│   │   └── helpers/          # Snackbar, app bar helpers
│   ├── routes/               # Navigation, destinations, route utils, nav observers
│   ├── services/             # Non-DB domain services (e.g. supported_icon)
│   ├── extensions/           # Dart/Flutter extension methods
│   └── utils/                # Logger, app utils, misc helpers
└── i18n/
    ├── json/                 # Translation SOURCES (edit these) — en.json, es.json, ...
    ├── generated/            # GENERATED translations.g.dart — never edit by hand
    └── scripts/              # Python helper to translate missing keys

assets/
├── sql/                      # initial_categories.json, initial_currencies.json
│   └── migrations/           # vN.sql schema migrations (see README there)
├── fonts/                    # Nunito, Exo 2, Cairo, Jost
└── resources/, icons/        # App icon and in-app icon assets

android/  windows/            # Platform runners
test/                         # Unit tests (flutter_test), + integration_test
docs/                         # Contributing, run-locally, commit + branch conventions
```

## Run Targets

| Task                    | Command                                                    |
| ----------------------- | ---------------------------------------------------------- |
| Install deps            | `flutter pub get`                                          |
| Run (debug)             | `flutter run`                                              |
| Run on Windows          | `flutter run -d windows`                                   |
| Analyze / lint          | `flutter analyze`                                          |
| Format                  | `dart format .`                                            |
| Tests                   | `flutter test`                                             |
| Code generation (once)  | `dart run build_runner build --delete-conflicting-outputs` |
| Code generation (watch) | `dart run build_runner watch --delete-conflicting-outputs` |
| Translations only       | `dart run slang`                                           |
| Regenerate app icons    | `dart run flutter_launcher_icons`                          |

---

## Code Generation (IMPORTANT)

This project relies heavily on code generation. **Never edit generated files by hand** — they are overwritten. Generated files end in:

- `*.g.dart` — drift (`app_db.g.dart`), `json_serializable`, `copy_with_extension`, and slang (`translations.g.dart`).
- `*.freezed.dart` — `freezed` (excluded from analysis in `analysis_options.yaml`).

After changing any of the following, **regenerate**:

- Drift tables (`.drift` files) or `@DriftDatabase` includes → run `build_runner`.
- Models annotated with `@freezed`, `@CopyWith`, or `@JsonSerializable` → run `build_runner`.
- Enums used by drift converters (`custom_enum_converter.dart`) → run `build_runner`.
- Translation JSON in `lib/i18n/json/` → run `dart run slang` (faster) or `build_runner`.

Build config lives in `build.yaml` (drift dialect/options, slang settings, copy_with).

---

## Agent Playbook

### Adding a feature that stores/reads data

1. **Model** → add/extend a domain model in `lib/core/models/<domain>/` (use `freezed`/`copy_with`/`json_serializable` as the neighbors do).
2. **Schema** → if a new table/column is needed, edit the `.drift` files in `lib/core/database/sql/`. **Do NOT create a DB migration or bump the schema version** unless the prompt explicitly asks for it — see the "Database migrations" rule below.
3. **Service** → add methods to the matching `lib/core/database/services/<domain>/*_service.dart`. Follow the singleton pattern (see below). Prefer reactive `Stream`s (`watch...`) for anything the UI observes.
4. **Regenerate** → run `build_runner` (step above).
5. **UI** → build screens/widgets under `lib/app/<feature>/`. Reuse shared widgets from `lib/core/presentation/widgets/` before creating new ones.
6. **Routing** → if it's a top-level page, wire it in `lib/core/routes/`.
7. **Test** → add/adjust tests in `test/`.
8. **Strings (do this LAST)** → only once all the code is finalized, add keys to `lib/i18n/json/en.json` (base locale) and run `dart run slang`. Never hardcode user-facing text — use `t.some.key`. See the "Translations" timing note below.

### Service pattern (singletons)

Data-access services expose a private constructor + a static `instance`, holding a reference to `AppDB.instance`:

```dart
class TransactionService {
  final AppDB db;

  TransactionService._(this.db);
  static final TransactionService instance = TransactionService._(AppDB.instance);

  Stream<List<MoneyTransaction>> getTransactions(/* ... */) { /* ... */ }
}
```

Consume via `TransactionService.instance.getTransactions(...)`. The same `._()` + `static final instance` pattern is used across DB services and several app-wide services (`UserSettingService`, `AppDataService`, `PrivateModeService`).

### UI patterns

- **Reactive UI**: wrap streams with `StreamBuilder`; DB queries return drift streams.
- **Theming**: use `Theme.of(context)` / `getThemeData(...)`; don't hardcode colors.
- **Responsive**: use helpers in `lib/core/presentation/responsive/` (`BreakPoint`, responsive row/column) and `AppUtils.isMobileLayout(context)`.
- **Feedback**: use the shared snackbar helpers, not raw `ScaffoldMessenger`.
- **Segmented controls**: use `ExpandingSegmentedTabs`/`SegmentedTabItem` (`lib/core/presentation/widgets/expanding_segmented_tabs.dart`) instead of Flutter's `SegmentedButton`/`ButtonSegment`. It adapts to narrow screens (collapsing unselected segments to just their icon instead of truncating labels) and hugs its content width when `fullWidth: false` is passed, unlike the native widget.

### Adding / editing translations

- **Timing — do translations LAST.** Adding/regenerating translations is expensive and churns generated files, so leave it until the very end, once all the code is final and reviewed. Don't interleave translation work with feature/logic changes. While building, it's fine to sketch keys, but only add them to the JSON and run `slang` as the final step.
- Edit only the **JSON sources** in `lib/i18n/json/` (values, not keys).
- Base locale is `en`. Run `dart run slang` to regenerate `translations.g.dart`.
- Interpolation uses double braces: `"hello": "Hi {{name}}"` → `t.hello(name: ...)`.
- See `lib/i18n/README.md` for the full translation guide.

### Database migrations

- **Never create a DB migration or bump the schema version unless a prompt explicitly asks for it.** Do not add or edit files in `assets/sql/migrations/` (`vN.sql`) or change the drift schema version on your own initiative.
- You may still edit `.drift` table/query definitions and services as part of a feature, but flag that a migration will eventually be needed rather than writing one — the maintainer decides when and how to migrate.
- When explicitly asked to migrate, follow the existing pattern and the guidance in `assets/sql/migrations/README.md`.

---

## Conventions

### Dart / Flutter

- Lints: `flutter_lints` + project rules in `analysis_options.yaml`. Notably:
  - `prefer_single_quotes` — use single quotes.
  - `unawaited_futures` — never leave a `Future` unawaited (await it or wrap in `unawaited(...)`).
  - `cancel_subscriptions`, `avoid_void_async`, `use_colored_box`, `use_decorated_box`, `prefer_final_in_for_each`, `throw_in_finally`.
- Prefer `const` constructors where possible.
- Keep widgets small and composable; extract reusable pieces into `core/presentation/widgets/`.
- Use `Logger.printDebug(...)` (see `lib/core/utils/logger.dart`) instead of `print`.

### File naming

Match the existing (mixed but consistent) conventions:

- Pages: `*.page.dart` (e.g. `transaction_form.page.dart`)
- Enums: `*.enum.dart`
- Services: `*_service.dart` or `*.service.dart`
- Extensions: `*.extension.dart` / `*.extensions.dart`
- Modals: `*.modal.dart`
- Generated: `*.g.dart`, `*.freezed.dart` (do not create/edit manually)

### Data & privacy

- **Offline-first**: all data lives in a local SQLite DB on-device. No cloud, no telemetry, no ads. Never introduce network calls that phone home.
- Backups are **local files** the user controls (`core/database/backup/`).
- Never log sensitive financial data.

---

## Validation Checklist

Before completing any task:

- [ ] `flutter analyze` is clean (no new warnings/errors).
- [ ] `dart format .` applied.
- [ ] Code generation run if models/tables/enums/translations changed (`build_runner` / `slang`), and generated files are up to date.
- [ ] `flutter test` passes.
- [ ] App builds and the changed screens work on at least one target (Android and/or Windows).
- [ ] No hardcoded user-facing strings — but only add the actual `t.*` keys and run `slang` as the final step, after the code is done.
- [ ] No DB migration was created unless the prompt explicitly requested one.
- [ ] Changes are minimal and surgical.

---

## Git / Contribution Workflow

- Branch off **`develop`**, never `main`. Naming: `fix/XXXX` (issue number) or `feature/some-new-feature`.
- `main` and `develop` are protected; open PRs against **`develop`**.
- Follow the commit message convention in `docs/COMMIT_MSG.md` and branch workflow in `docs/GIT_BRANCHES_WORKFLOW.md`.
- There is no separate QA — **you are the QA**. Test carefully on supported platforms.
- Do not create commits unless explicitly asked. When asked to commit AI-generated work, add the trailer `Includes-AI-Code: true` to the commit message.

---

## Plan Mode

- Make plans extremely concise. Sacrifice grammar for brevity.
- End with unresolved questions, if any.

---

When in doubt, follow the nearest existing pattern.
