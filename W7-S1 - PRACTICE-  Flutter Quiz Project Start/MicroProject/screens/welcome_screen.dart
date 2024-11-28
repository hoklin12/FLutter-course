import 'package:flutter/material.dart';

Color appColor = Colors.blue[500] ?? Colors.blue; // Fallback if null

class WelcomeScreen extends StatelessWidget {
 final VoidCallback onStart;

 WelcomeScreen({required this.onStart});

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(title: Text('Welcome to the Quiz')),
   backgroundColor: appColor,
   body: Center(
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
      Image.asset(
       'assets/w4s2/quiz-logo.png', // Path to your asset
       width: 200,
       height: 200,
       fit: BoxFit.cover,
      ),
      SizedBox(height: 40), // Adds spacing between the image and button
      ElevatedButton(
       onPressed: onStart, // Start the quiz when button is pressed
       child: Text('Start Quiz'),
      ),
     ],
    ),
   ),
  );
 }
}
