import 'package:flutter/material.dart';
import 'new_task_screen.dart';

class TaskPage extends StatelessWidget {
  final String category;

  const TaskPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Tasks in "$category" category'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewTaskScreen(selectedCategory: category),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}
