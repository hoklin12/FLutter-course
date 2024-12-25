import 'package:flutter/material.dart';
import 'widgets/memory_game_home.dart';

void main() {
  runApp(MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.orange[50],
      ),
      home: MemoryGameHome(),
    );
  }
}
