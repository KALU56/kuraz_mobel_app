import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/all_detal.dart';
import 'package:todo_app/widget/task_card.dart';
import 'package:todo_app/widget/task_list.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Access TaskProvider to manage tasks
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      // App Bar with title and credits button
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showCreditsDialog(context),
          ),
        ],
      ),

      // Main Body Content
      body: Column(
        children: [
          // Summary Cards Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // All Tasks Card
                Expanded(
                  child: TaskCard(
                    title: 'All Tasks',
                    count: taskProvider.allTasks.length,
                    color: Colors.blue[100]!,
                  ),
                ),
                const SizedBox(width: 16),
                // Completed Tasks Card
                Expanded(
                  child: TaskCard(
                    title: 'Completed',
                    count: taskProvider.completedTasks.length,
                    color: Colors.green[100]!,
                  ),
                ),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.allTasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.allTasks[index];
                return TaskListTile(
                  task: task,
                  onTap: () => _navigateToTaskDetail(context, task),
                  onToggleComplete: (value) {
                    taskProvider.updateTask(task.id, isCompleted: value);
                  },
                  onDelete: () => _confirmDeleteTask(context, task.id),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button for Adding New Tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  // ================ HELPER METHODS ================ //

  // Show Add Task Dialog
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Task Title Input
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              const SizedBox(height: 16),
              // Due Date Picker
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) selectedDate = date;
                },
                child: Text('Due: ${selectedDate.toLocal().toString().split(' ')[0]}'),
              ),
            ],
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            // Add Task Button
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).createTask(
                    titleController.text,
                    selectedDate,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  // Navigate to Task Detail Screen
  void _navigateToTaskDetail(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );
  }

  // Confirm Task Deletion
  void _confirmDeleteTask(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).deleteTask(taskId);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Show App Credits Dialog
  void _showCreditsDialog(BuildContext context) {
    final credits = Provider.of<TaskProvider>(context, listen: false).appCredits;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('App Credits'),
          content: Text(credits),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}