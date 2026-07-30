# Expense Tracker (Flutter)

A cross-platform expense/income tracker for iOS and Android, matching the provided mockup:
Home, History, Report, and Dashboard screens.

## What's included
- **Home** — total balance card, today's income/expense, recent transactions, "View All" → History
- **History** — Expense/Income toggle, period filter (Today, 7 days, 1/3/6 month, 1 year)
- **Report** — donut chart of this month's expenses by category + income/expense summary
- **Dashboard** — balance trend sparkline, Quick Actions (Add Income / Add Expense — actually update the balance), Accounts list

No backend or external chart library — everything runs on in-memory state
(`lib/state/app_state.dart`), so data resets when the app restarts. Swap in a database
(e.g. `sqflite` or `Hive`) or an API later without touching the UI layer.

## Setup

You'll need the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
(this project wasn't built or run in this environment, so run it locally to verify).

This archive contains the Dart source (`lib/`) and `pubspec.yaml` only — the native
`android/` and `ios/` platform folders aren't included. Generate them once, in this
folder, before your first run:

```bash
flutter create .
flutter pub get
```

`flutter create .` scaffolds the native projects around the existing `lib/` folder
without touching your code.

## Run

```bash
# iOS Simulator (macOS + Xcode required)
flutter run -d ios

# Android Emulator or device
flutter run -d android

# List available devices
flutter devices
```

## Build for release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (macOS + Xcode required, then archive via Xcode or:)
flutter build ios --release
```

## Project structure

```
lib/
  main.dart                  # App entry point
  theme.dart                 # Colors & text styles
  models/
    transaction.dart         # TransactionItem model
  state/
    app_state.dart           # In-memory app state (transactions, balance, totals)
  screens/
    main_navigation.dart     # Bottom tab shell (Home/Report/Dashboard)
    home_screen.dart
    history_screen.dart
    report_screen.dart
    dashboard_screen.dart
  widgets/
    balance_card.dart
    summary_card.dart
    transaction_tile.dart
    donut_chart.dart         # Custom-painted, no external chart package
    sparkline_chart.dart     # Custom-painted
    add_transaction_sheet.dart
    bottom_nav_bar.dart
```

## Notes / next steps
- Currency is hardcoded to ₹ (INR) to match the mockup — change the symbol in
  `theme.dart`/widgets if you need another currency.
- "Add Account" and "View All" (Accounts) are currently static — wire them up to
  real account-management screens as needed.
- For persistence across app restarts, add `shared_preferences`, `sqflite`, or `Hive`
  and load/save from `AppState`.
