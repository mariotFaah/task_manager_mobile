import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.onCreate});
  final ValueChanged<Task> onCreate;
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  TaskPriority priority = TaskPriority.medium;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  String? requiredField(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label is required' : null;

  void submit() {
    if (!formKey.currentState!.validate()) return;
    widget.onCreate(Task(
        id: DateTime.now().toIso8601String(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        category: categoryController.text.trim(),
        dueDate: DateTime.now().add(const Duration(days: 1)),
        priority: priority));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('New task')),
        body: Form(
          key: formKey,
          child: ListView(padding: const EdgeInsets.all(24), children: [
            Text('Capture what matters next.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 24),
            TextFormField(
                controller: titleController,
                validator: (v) => requiredField(v, 'Title'),
                decoration: const InputDecoration(
                    labelText: 'Title', prefixIcon: Icon(Icons.edit_outlined))),
            const SizedBox(height: 16),
            TextFormField(
                controller: descriptionController,
                maxLines: 4,
                validator: (v) => requiredField(v, 'Description'),
                decoration: const InputDecoration(
                    labelText: 'Description',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.notes_outlined))),
            const SizedBox(height: 16),
            TextFormField(
                controller: categoryController,
                validator: (v) => requiredField(v, 'Category'),
                decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.sell_outlined))),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskPriority>(
                initialValue: priority,
                decoration: const InputDecoration(
                    labelText: 'Priority',
                    prefixIcon: Icon(Icons.flag_outlined)),
                items: TaskPriority.values
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item.label)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => priority = value ?? priority)),
            const SizedBox(height: 28),
            FilledButton.icon(
                onPressed: submit,
                icon: const Icon(Icons.add),
                label: const Text('Create task')),
          ]),
        ),
      );
}
