import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskListTile extends StatelessWidget {
  final Task task;
  final Function(bool) onToggleComplete;
  final Function() onTap;
  final Function() onDelete;

  const TaskListTile({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onToggleComplete(value ?? false),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          'Due: ${task.dueDate.toLocal().toString().split(' ')[0]}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onTap,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}