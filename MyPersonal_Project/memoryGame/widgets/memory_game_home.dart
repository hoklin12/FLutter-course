import 'package:flutter/material.dart';
import '../screens/game_screen.dart';
import '../models/bot_logic.dart';

class MemoryGameHome extends StatefulWidget {
  @override
  _MemoryGameHomeState createState() => _MemoryGameHomeState();
}

class _MemoryGameHomeState extends State<MemoryGameHome> {
  double difficulty = 2.0; // Default is 'Medium'
  String selectedMode = "Bot";
  BotDifficulty selectedDifficulty = BotDifficulty.medium; // Default difficulty

  void _startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(mode: selectedMode, difficulty: selectedDifficulty),
      ),
    );
  }

  String getDifficultyLabel() {
    if (difficulty <= 1.5) return "EASY";
    if (difficulty <= 2.5) return "MEDIUM";
    return "HARD";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title
              Text(
                'MEMORY',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Flip two cards and find pairs.',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 40),

              // Difficulty Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(children:[
                  Icon(Icons.mood, color: Colors.redAccent, size: 60),
                  SizedBox(height: 10),
                  Text(getDifficultyLabel(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  SizedBox(height: 20),

                  // Slider for Difficulty
                  Slider(
                      value:difficulty,
                      min :1.0,
                      max :3.0,
                      divisions :2,
                      activeColor :Colors.redAccent,
                      inactiveColor :Colors.grey[300],
                      onChanged :(value){
                        setState(() {
                          difficulty = value;
                          selectedDifficulty = getSelectedDifficulty(value);
                        });
                      }),
                  Text("Drag to adjust difficulty", style :TextStyle(color :Colors.grey[700])),
                ]),
              ),
              SizedBox(height: 40),

              // Buttons
              ElevatedButton(
                  style :ElevatedButton.styleFrom(backgroundColor :Colors.redAccent,padding :EdgeInsets.symmetric(horizontal :60 , vertical :20),shape :RoundedRectangleBorder(borderRadius :BorderRadius.circular(15),),),
                  onPressed : () {setState(() {selectedMode = "Bot";}); _startGame();},
                  child :Text('PLAY vs. BOT', style :TextStyle(fontSize :20 , color :Colors.white))),
              SizedBox(height: 20),
              ElevatedButton(
                  style :ElevatedButton.styleFrom(backgroundColor :Colors.deepPurpleAccent,padding :EdgeInsets.symmetric(horizontal :60 , vertical :20),shape :RoundedRectangleBorder(borderRadius :BorderRadius.circular(15),),),
                  onPressed : () {setState(() {selectedMode = "Friend";}); _startGame();},
                  child :Text('PLAY vs. FRIEND', style :TextStyle(fontSize :20 , color :Colors.white))),
            ],
          ),
        ),
      ),
    );
  }

  BotDifficulty getSelectedDifficulty(double value) {
    if (value <= 1.5) return BotDifficulty.easy;
    if (value <= 2.5) return BotDifficulty.medium;
    return BotDifficulty.hard;
  }
}
