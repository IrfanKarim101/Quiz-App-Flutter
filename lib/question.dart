import 'package:flutter/material.dart';
import 'result.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}


class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Question> questions = [
    Question(
      question: "What are the building blocks of Flutter UIs?",
      options: ["Components", "Blocks", "Functions", "Widgets"],
      correctAnswer: 3,
    ),
    Question(
      question: "How are Flutter UIs built?",
      options: [
        "By defining widgets in config files",
        "By combining widgets in code",
        "By using XML layouts",
        "By using CSS styles"
      ],
      correctAnswer: 1,
    ),
    Question(
      question: "What are the building blocks of Flutter UIs?",
      options: ["Components", "Blocks", "Functions", "Widgets"],
      correctAnswer: 3,
    ),
    Question(
      question: "Which programming language is used to write Flutter apps?",
      options: ["Java", "Kotlin", "Dart", "Swift"],
      correctAnswer: 2,
    ),
    Question(
      question: "What is the name of Flutter's UI rendering engine?",
      options: ["Skia", "Blink", "WebKit", "EdgeHTML"],
      correctAnswer: 0,
    ),
    Question(
      question: "Which company developed Flutter?",
      options: ["Apple", "Google", "Microsoft", "Facebook"],
      correctAnswer: 1,
    ),
    Question(
      question: "What is the command to create a new Flutter project?",
      options: [
        "flutter new",
        "flutter create",
        "flutter init",
        "flutter start"
      ],
      correctAnswer: 1,
    ),
    Question(
      question: "Which widget is used for layout in Flutter?",
      options: ["Container", "Column", "Row", "All of the above"],
      correctAnswer: 3,
    ),
    // Question(
    //   question: "How do you access native features in Flutter?",
    //   options: [
    //     "Using plugins",
    //     "Using channels",
    //     "Using packages",
    //     "All of the above"
    //   ],
    //   correctAnswer: 3,
    // ),
    Question(
      question: "What is the default build mode for Flutter apps?",
      options: ["Debug", "Release", "Profile", "Test"],
      correctAnswer: 0,
    ),
    Question(
      question: "Which widget is used to create an infinite list in Flutter?",
      options: ["ListView", "GridView", "PageView", "CustomScrollView"],
      correctAnswer: 0,
    ),
  ];

  void _checkAnswer(int selectedOption) {
    if (selectedOption == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {// Check if there are more questions
      setState(() {
        currentQuestionIndex++;
      });
    } else {

      // Navigate to results page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultsPage(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A1B7D),
              Color(0xFF462996),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,// Stretch the column
              children: [
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 40),
                Text(
                  questions[currentQuestionIndex].question, // Display the question
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ...List.generate( // Generate a list of buttons
                  4,// Generate 4 buttons
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () => _checkAnswer(index),// Check the answer
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.white.withOpacity(0.1),
                        // onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        questions[currentQuestionIndex].options[index], // Display the option
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
