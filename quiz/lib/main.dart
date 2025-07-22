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
      'category': 'Programming',
      'Q': 'What is Java?',
      'choice': ['Programming language', 'Coffee', 'Car', 'Animal'],
    },
    {
      'category': 'Programming',
      'Q': 'What is Python?',
      'choice': ['Programming language', 'Snake', 'Drink', 'Bike'],
    },
    {
      'category': 'Science',
      'Q': 'What is Gravity?',
      'choice': ['Force', 'Animal', 'Planet', 'Gas'],
    },
  ];

  String? selectedCategory;
  List<Map<String, dynamic>> filteredQuestions = [];
  int currentQuestionIndex = 0;

  void filterQuestionsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      filteredQuestions =
          questions.where((q) => q['category'] == category).toList();
      currentQuestionIndex = 0;
    });
  }

  void goToNext() {
    setState(() {
      if (currentQuestionIndex < filteredQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You reached the end")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = questions
        .map((q) => q['category'] as String)
        .toSet()
        .toList(); // get unique categories

    if (filteredQuestions.isEmpty) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: selectedCategory,
                onChanged: (value) {
                  if (value != null) {
                    filterQuestionsByCategory(value);
                  }
                },
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Please select a category to begin.'),
            ],
          ),
        ),
      );
    }

    final current = filteredQuestions[currentQuestionIndex];
    final String questionText = current['Q'];
    final List<String> choices = List<String>.from(current['choice']);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: const Text('Select Category'),
              value: selectedCategory,
              onChanged: (value) {
                if (value != null) {
                  filterQuestionsByCategory(value);
                }
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            Text(
              'Question ${currentQuestionIndex + 1}: $questionText',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            ElevatedButton(
              onPressed: goToNext,
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
