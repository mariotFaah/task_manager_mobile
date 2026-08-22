import '../models/task.dart';

final List<Task> sampleTasks = [
  Task(
    id: '1',
    title: 'Plan the weekly groceries',
    description: 'Check the fridge, prepare the list and order essentials.',
    category: 'Personal',
    dueDate: DateTime(2026, 8, 22, 18),
    priority: TaskPriority.high,
  ),
  Task(
    id: '2',
    title: 'Reply to project emails',
    description: 'Follow up with the design and product teams.',
    category: 'Work',
    dueDate: DateTime(2026, 8, 23, 10),
    priority: TaskPriority.medium,
  ),
  Task(
    id: '3',
    title: 'Morning run',
    description: 'A short 30 minute run around the park.',
    category: 'Health',
    dueDate: DateTime(2026, 8, 24, 7),
    priority: TaskPriority.low,
  ),
  Task(
    id: '4',
    title: 'Read 20 pages',
    description: 'Continue the current book before bed.',
    category: 'Learning',
    dueDate: DateTime(2026, 8, 24, 21),
    priority: TaskPriority.low,
    isCompleted: true,
  ),
];

const categories = ['All', 'Work', 'Personal', 'Health', 'Learning'];
