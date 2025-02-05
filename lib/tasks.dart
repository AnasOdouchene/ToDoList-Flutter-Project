import 'package:flutter/material.dart';
import 'package:todolist_app/tasks_list.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'models/task.dart'; // Importer la classe Task depuis votre fichier models

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  // Liste statique de tâches
  final List<Task> _registeredTasks = [
    Task(
      title: 'Apprendre Flutter',
      description: 'Suivre le cours pour apprendre de nouvelles compétences',
      date: DateTime.now(),
      category: Category.work,
    ),
    Task(
      title: 'Faire les courses',
      description: 'Acheter des provisions pour la semaine',
      date: DateTime.now().subtract(Duration(days: 1)),
      category: Category.shopping,
    ),
    Task(
      title: 'Rédiger un CR',
      description: 'Écrire un compte rendu de réunion',
      date: DateTime.now().subtract(Duration(days: 2)),
      category: Category.personal,
    ),
  ];

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewTask(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text('The title'),
          Text('Tasks list...'),
          Expanded(child: TasksList(tasks: _registeredTasks))
        ],
      ),
    );
  }
}
