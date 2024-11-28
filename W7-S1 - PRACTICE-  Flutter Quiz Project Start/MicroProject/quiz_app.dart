import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/screens/welcome_screen.dart';
import 'package:new_flutter_app/MicroProject/screens/question_screen.dart';
import 'package:new_flutter_app/MicroProject/screens/result_screen.dart';
import 'package:new_flutter_app/MicroProject/model/submission.dart';
import 'package:new_flutter_app/MicroProject/model/quiz.dart';
import 'package:new_flutter_app/MicroProject/model/quiz_state.dart';

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  // Constructor
  QuizApp(this.quiz, {super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  int currentQuestionIndex = 0;
  Submission submission = Submission();

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

  void resetQuiz() {
    setState(() {
      quizState = QuizState.notStarted;
      currentQuestionIndex = 0;
      submission.clear();
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
          question: widget.quiz.questions[currentQuestionIndex],
          submission: submission, // Pass submission here
        );
      case QuizState.finished:
        return ResultScreen(
          score: submission.getScore(),
          onStart: resetQuiz,
          submission: submission, // Pass the submission object
          questions: widget.quiz.questions, // Pass questions list to ResultScreen
        );
      default:
        return WelcomeScreen(onStart: startQuiz);
    }
  }
}
