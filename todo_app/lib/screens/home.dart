import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';

import 'package:todo_app/screens/all_detal.dart';
import 'package:todo_app/widget/task_card.dart';
import 'package:todo_app/widget/task_list.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
    appBar: AppBar(
      title: Text(
        'Hello ',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            const SizedBox(height: 24),
            
            // Task Summary Cards
            Row(
              children: [
                TaskCard(
                  title: "Today",
                  icon: Icons.today,
                  count: taskProvider.todayTaskCount,
                  color: Colors.blue[100]!,
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                TaskCard(
                  title: "Completed",
                  icon: Icons.check_circle,
                  count: taskProvider.completedTaskCount,
                  color: Colors.green[100]!,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TaskCard(
                  title: "All",
                  icon: Icons.list,
                  count: taskProvider.allTaskCount,
                  color: Colors.purple[100]!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllDetail()),
                    );
                  },
                ),
                const SizedBox(width: 16),
                TaskCard(
                  title: "Overdue",
                  icon: Icons.warning,
                  count: taskProvider.overdueTaskCount,
                  color: Colors.orange[100]!,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Today's Tasks
            Text(
              'Today\'s Tasks',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            
            if (taskProvider.todayTasks.isEmpty)
              const Center(
                child: Text('No tasks for today'),
              )
            else
              Column(
                children: taskProvider.todayTasks.map((task) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TaskList(
                      task: task,
                      onCheckboxChanged: (value) {
                        taskProvider.toggleTaskCompletion(task.id);
                      },
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    String taskTitle = '';
    TimeOfDay selectedTime = _timeOfDay;
    DateTime selectedDate = _selectedDate;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => taskTitle = value,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            selectedDate = date;
                          }
                        },
                        child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (time != null) {
                            selectedTime = time;
                          }
                        },
                        child: Text(
                          selectedTime.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    taskTitle,
                    selectedTime,
                    selectedDate,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}