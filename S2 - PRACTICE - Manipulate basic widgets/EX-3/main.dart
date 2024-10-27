import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 600,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(16.0),
              // Padding inside the decoration
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(30.0), // Rounded corners (optional)
              ),
              child: const Text(
                'OOP',
                style: TextStyle(fontSize: 24, color: Colors.white,),textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 600,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(16.0),
              // Padding inside the decoration
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(30.0), // Rounded corners (optional)
              ),
              child: const Text(
                'DART',
                style: TextStyle(fontSize: 24, color: Colors.white,),textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 600,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(16.0),
              // Padding inside the decoration
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(30.0), // Rounded corners (optional)
              ),
              child: const Text(
                'FLUTTER',
                style: TextStyle(fontSize: 24, color: Colors.white,),textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ),
      ),
    ),
  );
}
