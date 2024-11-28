import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/model/question.dart';

Color appColor = Colors.blue[500] ?? Colors.blue; // Fallback if null

class QuestionScreen extends StatelessWidget {
  final VoidCallback onFinish;
  final Question question;

  QuestionScreen({required this.onFinish, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question'),
        backgroundColor: appColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: appColor, width: 2),
              ),
              child: Text(
                question.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20), // Spacing between question and answers

            // Answer Buttons
            ...question.possibleAnswers.map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: onFinish, // Go to the next question or finish quiz
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

