import 'package:flutter/material.dart';

void main() {
  runApp(const quizApp());
}

class quizApp extends StatelessWidget {
  const quizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<Map<String, dynamic>> questions = [
    {
      'Q': 'what is java?',
      'choice': ['peogramin', 'coffee', 'car', 'animal'],
    },
    {
      'Q': 'what is javaghj?',
      'choice': ['peogramin', 'coffeghje', 'car', 'animal'],
    },
    {
      'Q': 'what is javaghjk?',
      'choice': ['peohjkkgramin', 'coffee', 'car', 'animal'],
    },
  ];
  int CurrentQuationIndex = 0;
  void goToNext() {
    setState(() {
      if (CurrentQuationIndex < questions.length - 1) {
        CurrentQuationIndex++;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("you reached the end")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[CurrentQuationIndex];
    final String questionText = current['Q'];
    final List<String> choices = List<String>.from(current['choice']);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${CurrentQuationIndex + 1}: $questionText',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...choices.map((choice) {
              return ElevatedButton(
                onPressed: () {
                  print('You chose: $choice');
                },
                child: Text(choice),
              );
            }).toList(),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  goToNext();
                },
                child: const Text('NEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
