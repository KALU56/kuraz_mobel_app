import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;
  List<Task> get todayTasks => _tasks.where((task) => task.isToday).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();
  
  int get todayTaskCount => todayTasks.length;
  int get allTaskCount => _tasks.length;
  int get overdueTaskCount => _tasks.where((task) => task.isOverdue).length;
  int get completedTaskCount => completedTasks.length;

  void addTask(String title, TimeOfDay time, DateTime date) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      time: time,
      date: date,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void deleteAllCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }
}