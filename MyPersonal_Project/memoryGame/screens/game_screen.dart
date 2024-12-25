import 'package:flutter/material.dart';
import '../models/bot_logic.dart';

class GameScreen extends StatefulWidget {
  final String mode;
  final BotDifficulty? difficulty;

  GameScreen({required this.mode, this.difficulty});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> cardImages = [
    'mouse', 'mouse', 'cat', 'cat', 'dog', 'dog',
    'rabbit', 'rabbit', 'bear', 'bear',
    'lion', 'lion', 'tiger', 'tiger',
    'elephant', 'elephant'
  ];

  List<bool> cardFlipped = List.generate(16, (index) => false);

  int player1Score = 0;
  int player2Score = 0; // Ensure player2Score is declared
  int botScore = 0;

  List<int> selectedIndices = [];

  bool isPlayer1Turn = true;
  bool isPlayerTurn = true; // For bot vs player
  bool isGameOver = false;

  late BotLogic botLogic;

  @override
  void initState() {
    super.initState();
    cardImages.shuffle();
    if (widget.mode == 'Bot') {
      botLogic = BotLogic(cardImages, cardFlipped, widget.difficulty!);
    }
    _checkGameOver();
  }

  void flipCard(int index) {
    // Prevent flipping if already flipped or if it's not the player's turn
    if (selectedIndices.length < 2 && !cardFlipped[index] && isPlayerTurn) {
      setState(() {
        cardFlipped[index] = true;
        selectedIndices.add(index);
      });

      // Check for match if two cards are selected
      if (selectedIndices.length == 2) {
        Future.delayed(Duration(milliseconds: 500), () { // Adjusted delay for faster flipping
          _checkForMatch();
        });
      }
    }
  }

  void _checkForMatch() {
    if (selectedIndices.length == 2) {
      if (cardImages[selectedIndices[0]] == cardImages[selectedIndices[1]]) {
        setState(() {
          if (widget.mode == 'Friend') {
            isPlayer1Turn ? player1Score++ : player2Score++;
          } else { // Playing against bot
            isPlayerTurn ? player1Score++ : botScore++;
          }
          selectedIndices.clear();
        });
      } else {
        // Reset flipped state after a short delay if cards do not match
        Future.delayed(Duration(milliseconds: 300), () { // Faster reset for non-matching cards
          setState(() {
            cardFlipped[selectedIndices[0]] = false;
            cardFlipped[selectedIndices[1]] = false;
            selectedIndices.clear();

            // Switch turns based on game mode
            if (widget.mode == 'Friend') {
              isPlayer1Turn = !isPlayer1Turn; // Switch turns for friend mode
            } else {
              isPlayerTurn = false; // Switch to bot's turn
              Future.delayed(Duration(milliseconds: 300), () => _botTurn());
            }
          });
        });
      }
    }

    _checkGameOver();
  }

  void _botTurn() {
    if (!isGameOver) {
      List<int> availableCards = [];

      for (int i = 0; i < cardFlipped.length; i++) {
        if (!cardFlipped[i]) availableCards.add(i);
      }

      // If there are less than two cards available, return
      if (availableCards.length < 2) return;

      // Bot flips two random cards using BotLogic class method
      List<int> botSelectedCards = botLogic.getBotSelection();

      setState(() {
        cardFlipped[botSelectedCards[0]] = true;
        cardFlipped[botSelectedCards[1]] = true;
        selectedIndices.add(botSelectedCards[0]);
        selectedIndices.add(botSelectedCards[1]);
      });

      Future.delayed(Duration(seconds: 1), () {
        if (cardImages[botSelectedCards[0]] == cardImages[botSelectedCards[1]]) {
          setState(() {
            botScore++;
            selectedIndices.clear();
            _checkGameOver();
          });

          // Continue the bot's turn
          Future.delayed(Duration(seconds: 1), () => _botTurn());
        } else {
          setState(() {
            cardFlipped[botSelectedCards[0]] = false;
            cardFlipped[botSelectedCards[1]] = false;
            selectedIndices.clear();
            isPlayerTurn = true; // Switch back to player's turn
          });
        }
      });
    }
  }

  void _checkGameOver() {
    int totalPairs = cardImages.length ~/ 2;

    if ((widget.mode == 'Friend' && player1Score + player2Score == totalPairs) ||
        (widget.mode == 'Bot' && player1Score + botScore == totalPairs)) {

      setState(() {
        isGameOver = true;
      });

      String winnerMessage;

      if (widget.mode == 'Friend') {
        winnerMessage = player1Score > player2Score ? "Player One wins!" :
        player2Score > player1Score ? "Player Two wins!" : "It's a draw!";
      } else { // Bot mode
        winnerMessage = player1Score > botScore ? "You win!" :
        botScore > player1Score ? "Bot wins!" : "It's a draw!";
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Game Over"),
          content: Text(winnerMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == 'Friend' ? 'Play vs. Friend' : '${widget.difficulty} Bot Game'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: widget.mode == 'Friend' ? (isPlayer1Turn ? Colors.blue[100] : Colors.red[100]) :
        (isPlayerTurn ? Colors.blue[100] : Colors.red[100]),

        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.mode == 'Friend'
                    ? 'PLAYER ONE: $player1Score vs PLAYER TWO: $player2Score'
                    : 'YOU: $player1Score vs BOT: $botScore',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cardImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => flipCard(index),
                    child: Card(
                      color: Colors.yellow,
                      child: Center(
                        child:
                        cardFlipped[index]
                            ? Image.asset('assets/images/${cardImages[index]}.jpg') // Show actual image when flipped
                            : Container(color: Colors.yellow, height: double.infinity, width: double.infinity), // Placeholder image when not flipped
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

