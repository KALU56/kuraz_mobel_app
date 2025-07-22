import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const FurnitureApp());
}

class FurnitureApp extends StatelessWidget {
  const FurnitureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture App',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
