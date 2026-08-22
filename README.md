# TaskFlow

TaskFlow is a daily task manager built with Flutter. It helps users capture priorities, find tasks quickly and keep a simple view of what is next.

## Features

- Dashboard with open, completed and weekly task statistics
- Named-route navigation across Today, Tasks, Settings and New Task
- Search and category filtering on the task list
- Task detail screen with a passed `Task` parameter
- Validated form with title, description and category fields
- Light and dark themes
- Responsive dashboard layout for mobile and tablet widths
- Reusable widgets in `lib/widgets/`
- UI/data separation in `lib/models/` and `lib/data/`

## Project structure

```text
lib/
  data/task_data.dart
  models/task.dart
  screens/
  widgets/
  main.dart
```

## Launch instructions

1. Install Flutter 3.19 or newer and verify it with `flutter doctor`.
2. From this folder, run `flutter pub get`.
3. Start an emulator or connect a device.
4. Run `flutter run`.
5. For a browser build, use `flutter run -d chrome`.

## Screenshots

### Today dashboard

![TaskFlow Today dashboard](images/today.png)

### Filtered task list

![TaskFlow filtered task list](images/filtered_task.png)

### Task details

![TaskFlow task details](images/task_details.png)

### Dark theme

![TaskFlow dark theme](images/dark_theme.png)

## Evaluation checklist

The project includes five distinct screens, named routes, a searchable/filterable list, parameter passing to detail, a three-field validated form, theme switching, Material widgets including `ListView`, `GridView`, `Card`, `Stack`-ready responsive composition, and three reusable widgets.
