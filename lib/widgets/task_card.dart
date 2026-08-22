import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_formatter.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key,
      required this.task,
      required this.onTap,
      required this.onToggle});

  final Task task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onToggle;

  @override
  Widget build(BuildContext context) {
    final color = task.priority == TaskPriority.high
        ? const Color(0xffd95d39)
        : const Color(0xff26736b);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Checkbox(
                value: task.isCompleted,
                onChanged: onToggle,
                activeColor: const Color(0xff26736b)),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(task.category,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(formatFrenchDateTime(task.dueDate),
                      style: Theme.of(context).textTheme.bodySmall),
                ])),
            Icon(Icons.chevron_right,
                color: Theme.of(context).colorScheme.outline),
          ]),
        ),
      ),
    );
  }
}
