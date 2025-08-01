import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const TaskCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('$count', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}