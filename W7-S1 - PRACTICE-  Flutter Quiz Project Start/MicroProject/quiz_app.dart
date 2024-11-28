import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/screens/welcome_screen.dart';
import 'package:new_flutter_app/MicroProject/screens/question_screen.dart';
import 'package:new_flutter_app/MicroProject/screens/result_screen.dart';
import 'package:new_flutter_app/MicroProject/model/submission.dart';
import 'package:new_flutter_app/MicroProject/model/quiz.dart';
import 'package:new_flutter_app/MicroProject/model/quiz_state.dart'; // Make sure this import exists

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  // Constructor
  QuizApp(this.quiz, {super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted; // Default state
  int currentQuestionIndex = 0; // Track current question index
  Submission submission = Submission(); // To track answers

  void startQuiz() {
    setState(() {
      quizState = QuizState.started;
    });
  }

  void finishQuiz() {
    setState(() {
      quizState = QuizState.finished;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (quizState) {
      case QuizState.notStarted:
        return WelcomeScreen(onStart: startQuiz);
      case QuizState.started:
        return QuestionScreen(
          onFinish: () {
            if (currentQuestionIndex < widget.quiz.questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
              });
            } else {
              finishQuiz();
            }
          },
          question: widget.quiz.questions[currentQuestionIndex], // Pass the current question
        );
      case QuizState.finished:
        return ResultScreen(score: submission.getScore(), onRestart: startQuiz);
      default:
        return WelcomeScreen(onStart: startQuiz); // Default to WelcomeScreen
    }
  }
}

