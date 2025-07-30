import 'package:flutter/material.dart';
import 'new_task_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('Tasks in "$category" category will appear here.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewTaskScreen(selectedCategory: category),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }
}
