import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'TaskFlow',
        debugShowCheckedModeBanner: false,
        theme: theme(Brightness.light),
        darkTheme: theme(Brightness.dark),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
                path: '/',
                name: 'home',
                builder: (_, __) =>
                    HomeScreen(tasks: tasks, onToggle: toggleTask)),
            GoRoute(
                path: '/tasks',
                name: 'tasks',
                builder: (_, __) =>
                    TasksScreen(tasks: tasks, onToggle: toggleTask)),
            GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (_, __) => SettingsScreen(
                    isDark: isDark,
                    onThemeChanged: (value) => setState(() => isDark = value))),
            GoRoute(
                path: '/add',
                name: 'add-task',
                builder: (_, __) => AddTaskScreen(onCreate: addTask)),
            GoRoute(
                path: '/detail',
                name: 'task-detail',
                builder: (_, state) =>
                    TaskDetailScreen(task: state.extra! as Task)),
          ],
        ),
      );
}
