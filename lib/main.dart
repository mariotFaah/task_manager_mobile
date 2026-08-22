import 'package:flutter/material.dart';
import 'data/task_data.dart';
import 'models/task.dart';
import 'screens/add_task_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/tasks_screen.dart';

void main() => runApp(const TaskFlowApp());

class TaskFlowApp extends StatefulWidget {
  const TaskFlowApp({super.key});
  @override
  State<TaskFlowApp> createState() => _TaskFlowAppState();
}

class _TaskFlowAppState extends State<TaskFlowApp> {
  final tasks = [...sampleTasks];
  bool isDark = false;

  void toggleTask(Task task) => setState(() {
        final index = tasks.indexWhere((item) => item.id == task.id);
        if (index >= 0) {
          tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
        }
      });

  void addTask(Task task) => setState(() => tasks.insert(0, task));

  ThemeData theme(Brightness brightness) => ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff26736b),
          brightness: brightness,
        ),
        scaffoldBackgroundColor:
            brightness == Brightness.light ? const Color(0xfff7f5ef) : null,
        cardTheme: const CardThemeData(
          margin: EdgeInsets.zero,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: brightness == Brightness.light ? Colors.white : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xff26736b), width: 2),
          ),
        ),
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TaskFlow',
        debugShowCheckedModeBanner: false,
        theme: theme(Brightness.light),
        darkTheme: theme(Brightness.dark),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (_) => HomeScreen(tasks: tasks, onToggle: toggleTask),
          '/tasks': (_) => TasksScreen(tasks: tasks, onToggle: toggleTask),
          '/settings': (_) => SettingsScreen(
                isDark: isDark,
                onThemeChanged: (value) => setState(() => isDark = value),
              ),
          '/add': (_) => AddTaskScreen(onCreate: addTask),
          '/detail': (context) {
            final task = ModalRoute.of(context)!.settings.arguments! as Task;
            return TaskDetailScreen(task: task);
          },
        },
      );
}
