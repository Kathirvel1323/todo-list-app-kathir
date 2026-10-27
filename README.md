# To-Do List App

A Flutter task list. Add non-empty tasks, mark them complete, dismiss them to delete, and see the remaining count in the app. Empty and all-complete states are handled explicitly.

## Run

Open [DartPad](https://dartpad.dev/), choose Flutter, paste `lib/main.dart`, and press **Run**. For a local run, install Flutter, run `flutter create --platforms=web .` once, then run `flutter pub get` and `flutter run -d chrome`.

## Checklist

- Add non-empty tasks, complete them, and delete by swipe or button.
- Ignore blank task names and keep the remaining counter accurate.
- Assign each task a unique `ValueKey` and show an empty state when cleared.
- Run `flutter test`; GitHub Actions analyzes, tests, builds, and publishes the web preview.
