import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/task_data.dart';
import '../models/task.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.tasks, required this.onToggle});
  final List<Task> tasks;
  final ValueChanged<Task> onToggle;
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String query = '';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.tasks
        .where((task) =>
            (selectedCategory == 'All' || task.category == selectedCategory) &&
            '${task.title} ${task.description}'
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('All tasks'), actions: [
        IconButton(
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.tune),
            tooltip: 'Settings')
      ]),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: const InputDecoration(
                    hintText: 'Search tasks',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic_none)))),
        SizedBox(
            height: 42,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final category = categories[index];
                  return ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (_) =>
                          setState(() => selectedCategory = category));
                })),
        const SizedBox(height: 12),
        Expanded(
            child: filtered.isEmpty
                ? const EmptyState(
                    title: 'No tasks found',
                    message: 'Try a different search or category.')
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (_, index) {
                      final task = filtered[index];
                      return TaskCard(
                          task: task,
                          onTap: () => context.push('/detail', extra: task),
                          onToggle: (_) => widget.onToggle(task));
                    })),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/add'), child: const Icon(Icons.add)),
    );
  }
}
