// ignore_for_file: avoid_print

import 'dart:io';
import 'package:taskflow/cli/repository.dart';
import 'package:taskflow/cli/task_manager.dart';

Future<void> main(List<String> arguments) async {
  final manager = TaskManager(JsonTaskRepository(File('tasks.json')));
  if (arguments.isEmpty) {
    printUsage();
    return;
  }

  try {
    switch (arguments.first) {
      case 'add':
        final title = option(arguments, '--title');
        final description = option(arguments, '--description');
        final due = DateTime.parse(option(arguments, '--due'));
        final task = await manager.add(
            title: title, description: description, dueDate: due);
        print('Added ${task.id}: ${task.title}');
      case 'list':
        final tasks =
            await manager.list(sortByDueDate: arguments.contains('--sort-due'));
        for (final task in tasks) {
          print(
              '${task.completed ? '[x]' : '[ ]'} ${task.id} | ${task.title} | ${task.dueDate.toIso8601String()}');
        }
      case 'complete':
        final task = await manager.complete(arguments[1]);
        print('Completed: ${task.title}');
      case 'delete':
        await manager.delete(arguments[1]);
        print('Deleted: ${arguments[1]}');
      default:
        printUsage();
    }
  } on FormatException {
    print('Invalid date. Use ISO format, for example 2026-08-22T18:45:00.');
  } on RangeError {
    printUsage();
  } on Exception catch (error) {
    print(error);
  }
}

String option(List<String> arguments, String name) {
  final index = arguments.indexOf(name);
  if (index == -1 || index + 1 >= arguments.length)
    throw const FormatException();
  return arguments[index + 1];
}

void printUsage() {
  print('TaskFlow CLI');
  print(
      '  dart run bin/taskflow_cli.dart add --title TITLE --description TEXT --due ISO_DATE');
  print('  dart run bin/taskflow_cli.dart list [--sort-due]');
  print('  dart run bin/taskflow_cli.dart complete TASK_ID');
  print('  dart run bin/taskflow_cli.dart delete TASK_ID');
}
