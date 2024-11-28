import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/model/question.dart';
import 'package:new_flutter_app/MicroProject/model/quiz.dart';
import 'package:new_flutter_app/MicroProject/quiz_app.dart'; // Import QuizApp

void main() {
  final quiz = Quiz(
    title: 'General Knowledge Quiz',
    questions: [
      Question(
      title: "Who is the best teacher?",
      possibleAnswers: ["ronan", "hongly", 'leangsiv'],
      goodAnswer: 'ronan',
      ),
      Question(
      title: "Which color is the best?",
      possibleAnswers: ["blue", "red", 'green'],
      goodAnswer: 'red',
      ),
    ],
  );

  runApp(
    MaterialApp(  // MaterialApp is needed for Directionality
      home: QuizApp(quiz),  // Pass quiz object to QuizApp
      debugShowCheckedModeBanner: false,  // Optional: Hides the debug banner
    ),
  ); // Pass quiz object to QuizApp
}
