# TaskFlow

TaskFlow is a daily task manager with a Flutter interface and a pure Dart CLI. It helps users capture priorities, find tasks quickly and keep a simple view of what is next.

## Features

- Dashboard with data-driven open, completed and weekly task statistics
- GoRouter named navigation across Today, Tasks, Settings, New Task and details
- Search and category filtering on the task list
- Task detail screen with a passed `Task` parameter
- Validated form with title, description and category fields
- Light and dark themes
- Responsive dashboard layout with a 2-column mobile grid and 3-column tablet grid
- Reusable widgets in `lib/widgets/`
- UI/data separation in `lib/models/` and `lib/data/`

## Project structure

```text
lib/
  cli/
  data/task_data.dart
  models/task.dart
  screens/
  widgets/
  main.dart
bin/
  taskflow_cli.dart
test/
  task_manager_test.dart
```

## Dart CLI

The CLI stores tasks in `tasks.json` and supports creation, listing with due-date sorting, completion and deletion. The implementation uses a generic repository interface, JSON persistence, custom exceptions and a mock repository in unit tests.

```bash
dart run bin/taskflow_cli.dart add --title "Buy groceries" --description "Milk and vegetables" --due 2026-08-22T18:45:00
dart run bin/taskflow_cli.dart list --sort-due
dart run bin/taskflow_cli.dart complete TASK_ID
dart run bin/taskflow_cli.dart delete TASK_ID
flutter test test/task_manager_test.dart
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

## Certification checklist

| Requirement | Implementation |
| --- | --- |
| 4+ screens | Today dashboard, All tasks, Task details, New task and Settings |
| Navigation | GoRouter named routes in `lib/main.dart`, including `/detail` |
| Search/filter | Search field and category `ChoiceChip` filters in `TasksScreen` |
| Parameter passing | Task ID passed through `context.push('/detail/:taskId')` and read with GoRouter `pathParameters` |
| Validated form | Title, description and category validators in `AddTaskScreen` |
| Theme support | Material 3 light/dark themes and Settings switch |
| Widget variety | `ListView`, `GridView`, `Stack`, `Card`, `Checkbox`, `ChoiceChip`, `Form`, `TextFormField` and more |
| Reusable widgets | `TaskCard`, `StatCard` and `EmptyState` in `lib/widgets/` |
| Responsive UI | `LayoutBuilder` changes the dashboard grid for tablet widths |
| Data separation | Tasks, categories and dashboard calculations live outside screen widgets |

## CLI certification checklist

| Requirement | Implementation |
| --- | --- |
| Task operations | Add, list, sort, complete and delete in `TaskManager` |
| JSON persistence | Generic `Repository<T>` and `JsonTaskRepository` |
| OOP design | Abstract `TaskAction<T>`, interface implementation and model methods |
| Error handling | `TaskNotFoundException` and `InvalidTaskException` |
| Unit tests | Six tests with `MockRepository` in `test/task_manager_test.dart` |
| Argument parsing | CLI commands and named options in `bin/taskflow_cli.dart` |
