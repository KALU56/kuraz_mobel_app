import 'package:flutter/material.dart';
import 'package:todo_app/screens/new_task_screen.dart';

class TaskPage extends StatefulWidget {
  final String category;

  const TaskPage({super.key, required this.category});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<Map<String, String>> tasks = [];

  @override
  Widget build(BuildContext context) {
    // Filter tasks by category
    final filteredTasks = tasks.where((task) => task['category'] == widget.category).toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (context, index) {
          final task = filteredTasks[index];
          return ListTile(
            title: Text(task['title'] ?? ''),
            subtitle: Text('Due: ${task['dueDate'] ?? ''}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewTaskScreen(selectedCategory: widget.category),
            ),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}
