import 'exceptions.dart';
import 'models.dart';
import 'repository.dart';

abstract class TaskAction<T> {
  Future<T> execute();
}

class ListTasksAction extends TaskAction<List<Task>> {
  ListTasksAction(this.manager, {this.sortByDueDate = false});
  final TaskManager manager;
  final bool sortByDueDate;

  @override
  Future<List<Task>> execute() => manager.list(sortByDueDate: sortByDueDate);
}

class TaskManager {
  TaskManager(this.repository);
  final Repository<Task> repository;

  Future<Task> add({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    if (title.trim().isEmpty)
      throw const InvalidTaskException('title is required');
    if (description.trim().isEmpty) {
      throw const InvalidTaskException('description is required');
    }
    final tasks = await repository.readAll();
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      dueDate: dueDate,
    );
    await repository.saveAll([...tasks, task]);
    return task;
  }

  Future<List<Task>> list({bool sortByDueDate = false}) async {
    final tasks = await repository.readAll();
    if (sortByDueDate) tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return tasks;
  }

  Future<Task> complete(String id) async {
    final tasks = await repository.readAll();
    final index = tasks.indexWhere((task) => task.id == id);
    if (index == -1) throw TaskNotFoundException(id);
    final updated = tasks[index].copyWith(completed: true);
    tasks[index] = updated;
    await repository.saveAll(tasks);
    return updated;
  }

  Future<void> delete(String id) async {
    final tasks = await repository.readAll();
    final remaining = tasks.where((task) => task.id != id).toList();
    if (remaining.length == tasks.length) throw TaskNotFoundException(id);
    await repository.saveAll(remaining);
  }
}
