import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/stat_card.dart';
import '../widgets/task_card.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.tasks, required this.onToggle});
  final List<Task> tasks;
  final ValueChanged<Task> onToggle;

  @override
  Widget build(BuildContext context) {
    final pending = tasks.where((task) => !task.isCompleted).toList();
    final completed = tasks.where((task) => task.isCompleted).length;
    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow'), actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings')
      ]),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 700;
        return ListView(
            padding:
                EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 18),
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 56),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good morning, Dina',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        Text('A clear plan makes room for better days.',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ]),
                ),
                Positioned(
                    right: 0,
                    top: 2,
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(Icons.wb_sunny_outlined,
                            color: Theme.of(context).colorScheme.primary))),
              ]),
              const SizedBox(height: 28),
              GridView.count(
                  crossAxisCount: wide ? 3 : 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    StatCard(
                        value: '${pending.length}',
                        label: 'Open tasks',
                        color: Theme.of(context).colorScheme.primary),
                    StatCard(
                        value: '$completed',
                        label: 'Completed',
                        color: const Color(0xffd95d39)),
                    const StatCard(
                        value: '3',
                        label: 'Due this week',
                        color: Color(0xff7b5e3b))
                  ]),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Up next',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800)),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/tasks'),
                    child: const Text('See all'))
              ]),
              const SizedBox(height: 10),
              ...pending.take(3).map((task) => TaskCard(
                  task: task,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TaskDetailScreen(task: task))),
                  onToggle: (_) => onToggle(task))),
            ]);
      }),
      bottomNavigationBar: NavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            if (index == 1) Navigator.pushNamed(context, '/tasks');
            if (index == 2) Navigator.pushNamed(context, '/settings');
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Today'),
            NavigationDestination(
                icon: Icon(Icons.checklist_outlined), label: 'Tasks'),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined), label: 'Settings')
          ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add'),
          child: const Icon(Icons.add)),
    );
  }
}
