import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Task details')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          Container(
              height: 8,
              decoration: BoxDecoration(
                  color: task.priority == TaskPriority.high
                      ? const Color(0xffd95d39)
                      : const Color(0xff26736b),
                  borderRadius: BorderRadius.circular(8))),
          const SizedBox(height: 28),
          Text(task.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          Wrap(spacing: 8, children: [
            Chip(label: Text(task.category)),
            Chip(label: Text(task.priority.label))
          ]),
          const SizedBox(height: 26),
          Text('Description',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(task.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 28),
          ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: const Text('Due date'),
              subtitle: Text(formatFrenchDateTime(task.dueDate))),
          ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Status'),
              subtitle: Text(task.isCompleted ? 'Completed' : 'In progress')),
        ]),
      );
}
