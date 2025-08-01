import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late Task _editableTask;

  @override
  void initState() {
    super.initState();
    _editableTask = Task.fromMap(widget.task.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: _editableTask.title),
              decoration: const InputDecoration(labelText: 'Task Title'),
              onChanged: (value) => _editableTask.title = value,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _editableTask.dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _editableTask.dueDate = date;
                  });
                }
              },
              child: Text('Due Date: ${_editableTask.dueDate.toLocal().toString().split(' ')[0]}'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Completed:'),
                Switch(
                  value: _editableTask.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _editableTask.isCompleted = value;
                      _editableTask.completedAt = value ? DateTime.now() : null;
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _confirmDeleteTask(context),
                child: const Text('Delete Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    Provider.of<TaskProvider>(context, listen: false).updateTask(
      _editableTask.id,
      title: _editableTask.title,
      dueDate: _editableTask.dueDate,
      isCompleted: _editableTask.isCompleted,
    );
    Navigator.pop(context);
  }

  void _confirmDeleteTask(BuildContext context) {
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
                Provider.of<TaskProvider>(context, listen: false).deleteTask(_editableTask.id);
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to home screen
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}