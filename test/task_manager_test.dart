import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/cli/exceptions.dart';
import 'package:taskflow/cli/models.dart';
import 'package:taskflow/cli/repository.dart';
import 'package:taskflow/cli/task_manager.dart';

class MockRepository implements Repository<Task> {
  List<Task> stored = [];

  @override
  Future<List<Task>> readAll() async => [...stored];

  @override
  Future<void> saveAll(List<Task> items) async => stored = [...items];
}

void main() {
  late MockRepository repository;
  late TaskManager manager;

  setUp(() {
    repository = MockRepository();
    manager = TaskManager(repository);
  });

  test('adds a task with details', () async {
    final task = await manager.add(
      title: 'Buy groceries',
      description: 'Milk and vegetables',
      dueDate: DateTime(2026, 8, 22),
    );
    expect(task.title, 'Buy groceries');
    expect((await manager.list()).length, 1);
  });

  test('lists tasks sorted by due date', () async {
    await manager.add(
        title: 'Later', description: 'B', dueDate: DateTime(2026, 8, 24));
    await manager.add(
        title: 'Sooner', description: 'A', dueDate: DateTime(2026, 8, 22));
    final tasks = await manager.list(sortByDueDate: true);
    expect(tasks.map((task) => task.title), ['Sooner', 'Later']);
  });

  test('marks a task as completed', () async {
    final task = await manager.add(
        title: 'Read',
        description: 'Chapter one',
        dueDate: DateTime(2026, 8, 22));
    final completed = await manager.complete(task.id);
    expect(completed.completed, isTrue);
  });

  test('deletes a task', () async {
    final task = await manager.add(
        title: 'Delete me',
        description: 'Temporary',
        dueDate: DateTime(2026, 8, 22));
    await manager.delete(task.id);
    expect(await manager.list(), isEmpty);
  });

  test('rejects an unknown task id', () async {
    expect(() => manager.complete('missing'),
        throwsA(isA<TaskNotFoundException>()));
  });

  test('rejects an empty title', () async {
    expect(
        () => manager.add(
            title: '', description: 'Details', dueDate: DateTime.now()),
        throwsA(isA<InvalidTaskException>()));
  });
}
