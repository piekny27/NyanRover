import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class _Task {
  final String name;
  final String assignees;
  final IconData icon;
  final String route;
  final String tooltip;

  const _Task({
    required this.name,
    required this.assignees,
    required this.icon,
    required this.route,
    required this.tooltip,
  });
}

const allTasks = [
  _Task(
      name: 'Opinions',
      assignees: 'Aleksander',
      icon: FontAwesomeIcons.spinner,
      route: '/opinions',
      tooltip: 'In development'),
  _Task(
      name: 'Trophies',
      assignees: 'Piotr',
      icon: FontAwesomeIcons.spinner,
      route: '/trophies',
      tooltip: 'In development'),
  _Task(
      name: 'Notifications',
      assignees: 'Mateusz',
      icon: FontAwesomeIcons.spinner,
      route: '/notifications',
      tooltip: 'In development'),
  _Task(
      name: 'Demo 2: Random Words',
      assignees: '',
      icon: FontAwesomeIcons.check,
      route: '/demo2',
      tooltip: 'Done'),
  _Task(
      name: 'Demo 1: Counter',
      assignees: '',
      icon: FontAwesomeIcons.check,
      route: '/demo1',
      tooltip: 'Done'),
];

class _TasksListState extends State<TasksList> {
  var tasks = allTasks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemCount: tasks.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        final task = tasks[i];
        return Tooltip(
            message: task.tooltip,
            child: ListTile(
            leading: FaIcon(task.icon),
            title: Text(task.name),
            subtitle: Text(task.assignees),
            onTap: () => Navigator.pushNamed(context, task.route)),
        );
      },
      separatorBuilder: (context, i) => const Divider(),
    );
  }
}

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}
