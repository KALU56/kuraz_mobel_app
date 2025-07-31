import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/widget/task_list.dart';


class AllDetail extends StatefulWidget {
  const AllDetail({super.key});

  @override
  State<AllDetail> createState() => _AllDetailState();
}

class _AllDetailState extends State<AllDetail> {
  int _currentFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    List<Task> filteredTasks = _getFilteredTasks(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              taskProvider.deleteAllCompletedTasks();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton('All', 0),
                _buildFilterButton('Today', 1),
                _buildFilterButton('Pending', 2),
                _buildFilterButton('Completed', 3),
              ],
            ),
          ),
          Expanded(
            child: filteredTasks.isEmpty
                ? const Center(
                    child: Text('No tasks found'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TaskList(
                          task: task,
                          onCheckboxChanged: (value) {
                            taskProvider.toggleTaskCompletion(task.id);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<Task> _getFilteredTasks(TaskProvider taskProvider) {
    switch (_currentFilterIndex) {
      case 1: // Today
        return taskProvider.todayTasks;
      case 2: // Pending
        return taskProvider.pendingTasks;
      case 3: // Completed
        return taskProvider.completedTasks;
      default: // All
        return taskProvider.allTasks;
    }
  }

  Widget _buildFilterButton(String text, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentFilterIndex = index;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor: _currentFilterIndex == index
            ? Colors.blue.withOpacity(0.2)
            : Colors.transparent,
      ),
      child: Text(text),
    );
  }
}