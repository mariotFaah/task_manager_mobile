enum TaskPriority { low, medium, high }

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;

  Task copyWith({bool? isCompleted}) => Task(
        id: id,
        title: title,
        description: description,
        category: category,
        dueDate: dueDate,
        priority: priority,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}

extension TaskPriorityLabel on TaskPriority {
  String get label => switch (this) {
        TaskPriority.low => 'Low',
        TaskPriority.medium => 'Medium',
        TaskPriority.high => 'High',
      };
}
