import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int count;
  final Color color;
  final VoidCallback? onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '$count tasks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}