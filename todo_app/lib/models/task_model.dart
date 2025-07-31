import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final TimeOfDay time;
  final DateTime date;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    this.isCompleted = false,
  });

  String get formattedTime {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  bool get isOverdue {
    final now = DateTime.now();
    return date.isBefore(DateTime(now.year, now.month, now.day)) && !isCompleted;
  }
}