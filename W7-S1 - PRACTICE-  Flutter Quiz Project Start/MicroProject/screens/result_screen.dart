import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  ResultScreen({required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Finished'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You scored $score points!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: onRestart, // Restart the quiz when clicked
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
