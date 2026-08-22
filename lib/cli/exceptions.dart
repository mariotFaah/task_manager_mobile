class TaskNotFoundException implements Exception {
  const TaskNotFoundException(this.taskId);
  final String taskId;

  @override
  String toString() => 'Task not found: $taskId';
}

class InvalidTaskException implements Exception {
  const InvalidTaskException(this.message);
  final String message;

  @override
  String toString() => 'Invalid task: $message';
}
