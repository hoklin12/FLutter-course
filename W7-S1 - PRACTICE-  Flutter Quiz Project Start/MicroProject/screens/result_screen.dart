import 'package:flutter/material.dart';
import 'package:new_flutter_app/MicroProject/model/submission.dart';
import 'package:new_flutter_app/MicroProject/model/question.dart';
import 'package:new_flutter_app/MicroProject/model/answer.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final VoidCallback onStart;
  final Submission submission;
  final List<Question> questions;

  ResultScreen({
    required this.score,
    required this.onStart,
    required this.submission,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    Color appColor = Colors.blue[500] ?? Colors.blue; // Fallback if null

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results', style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Color doesn't matter as it will be overridden by the gradient
        ),),
      ),
      backgroundColor: appColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'You answered $score out of ${questions.length}!',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ),
            //   textAlign: TextAlign.center,
            // ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.red,
                  Colors.green,
                  Colors.yellow,
                  Colors.orange,
                  Colors.white,
                  Colors.purple,
                  Colors.indigo,
                ],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: Text(
                'You answered $score out of ${questions.length}!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color doesn't matter as it will be overridden by the gradient
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final answer = submission.getAnswerFor(question);
                  final isCorrect = answer != null && answer.isCorrect();
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row with colored number and question title
                          Row(
                            children: [
                              // Container with background color (green for correct, red for incorrect)
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isCorrect ? Colors.green : Colors.red, // Background color for number
                                  shape: BoxShape.circle, // Circular shape for the number
                                ),
                                child: Text(
                                  '${index + 1}', // Display just the number
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Text color for the number (white for contrast)
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10), // Space between number and question text
                              // Display the question title
                              Expanded(
                                child: Text(
                                  question.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Handle long text
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Add space between question and answers

                          // Display the possible answers
                          ...question.possibleAnswers.map((answerOption) {
                            final isSelected = answer?.value == answerOption;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  // Display the checkmark if the answer is selected
                                  if (isSelected)
                                    Icon(
                                      Icons.check,
                                      color: isCorrect ? Colors.green : Colors.red,
                                    ),
                                  const SizedBox(width: 8),
                                  Text(
                                    answerOption,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: isCorrect && isSelected
                                          ? Colors.green
                                          : !isCorrect && isSelected
                                          ? Colors.red
                                          : Colors.black, // Color the text based on correctness
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Restart Quiz button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: onStart, // Callback to restart the quiz
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                  padding: const EdgeInsets.symmetric(
                    vertical: 15, // Adjust vertical padding
                    horizontal: 30, // Adjust horizontal padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  elevation: 5, // Add a shadow effect
                ),
                child: Text(
                  'Restart Quiz',
                  style: TextStyle(
                    color: appColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
