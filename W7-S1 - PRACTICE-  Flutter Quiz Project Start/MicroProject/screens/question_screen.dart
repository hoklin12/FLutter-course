import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/model/question.dart';
import 'package:new_flutter_app/MicroProject/model/answer.dart';
import 'package:new_flutter_app/MicroProject/model/submission.dart';
import 'package:new_flutter_app/W6_S2/EX1/main.dart';

Color appColor = Colors.blue[500] ?? Colors.blue; // Fallback if null

class QuestionScreen extends StatelessWidget {
  final VoidCallback onFinish; // Callback for moving to the next screen
  final Question question; // The current question to display
  final Submission submission; // The Submission object to store user's answers

  QuestionScreen({
    required this.onFinish,
    required this.question,
    required this.submission,
  });

  void _submitAnswer(String selectedAnswer) {
    // Ensure that the `Answer` object is correctly created and added to `Submission`
    final answer = Answer(selectedAnswer, question.goodAnswer);
    submission.addAnswer(question, answer);
    onFinish(); // Move to the next question or finish the quiz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Color doesn't matter as it will be overridden by the gradient
          ),
        ),
        backgroundColor: appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the question
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
            const SizedBox(height: 20), // Add space

            // Display the possible answers as buttons
            ...question.possibleAnswers.map((answerOption) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _submitAnswer(answerOption), // Handle answer selection
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
                    answerOption,
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
