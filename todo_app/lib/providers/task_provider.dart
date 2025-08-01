import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get todayTasks => _tasks.where((task) => 
      task.dueDate.year == DateTime.now().year &&
      task.dueDate.month == DateTime.now().month &&
      task.dueDate.day == DateTime.now().day).toList();

  // CRUD Operations
  void createTask(String title, DateTime dueDate) {
    final task = Task.createNew(title: title, dueDate: dueDate);
    _tasks.add(task);
    notifyListeners();
  }

  Task? readTask(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  void updateTask(String id, {String? title, DateTime? dueDate, bool? isCompleted}) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[index];
      if (title != null) task.title = title;
      if (dueDate != null) task.dueDate = dueDate;
      if (isCompleted != null) {
        task.isCompleted = isCompleted;
        task.completedAt = isCompleted ? DateTime.now() : null;
      }
      task.updatedAt = DateTime.now();
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Credit/Attribution
  String get appCredits => '''
Todo App with CRUD Operations
Developed by [Your Name]
Version 1.0.0
Built with Flutter
© ${DateTime.now().year} All rights reserved
''';
}