class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.completed = false,
  });

  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool completed;

  Task copyWith({bool? completed}) => Task(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        completed: completed ?? this.completed,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'completed': completed,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        dueDate: DateTime.parse(json['dueDate'] as String),
        completed: json['completed'] as bool? ?? false,
      );
}
