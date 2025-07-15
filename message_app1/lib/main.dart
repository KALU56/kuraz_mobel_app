// Importing required Flutter and Firebase packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure Flutter widgets are ready before initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app (connect to Firebase project)
  await Firebase.initializeApp();

  // Run your Flutter app after Firebase is ready
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Test',
      home: Scaffold(
        appBar: AppBar(title: Text('Firebase Test')),
        body: Center(
          child: Text(
            '✅ Firebase connected successfully!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
