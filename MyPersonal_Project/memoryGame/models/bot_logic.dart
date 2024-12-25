import 'dart:math';

enum BotDifficulty { easy, medium, hard }

class BotLogic {
  final List<String> cardImages;
  final List<bool> cardFlipped;
  final BotDifficulty difficulty;

  BotLogic(this.cardImages, this.cardFlipped, this.difficulty);

  // Main function to get the bot's selection
  List<int> getBotSelection() {
    // Get all unflipped card indices
    List<int> availableCards = List.generate(cardFlipped.length, (index) => index)
        .where((index) => !cardFlipped[index])
        .toList();

    if (availableCards.length < 2) return []; // Not enough cards to flip

    switch (difficulty) {
      case BotDifficulty.easy:
        return _selectRandomCards(availableCards);
      case BotDifficulty.medium:
        return _mediumLogic(availableCards);
      case BotDifficulty.hard:
        return _hardLogic(availableCards);
    }

    return []; // Fallback in case of unexpected behavior.
  }


// Easy bot logic and other methods remain unchanged...

  List<int> _selectRandomCards(List<int> availableCards) {
    Random random = Random();
    int firstCardIndex = availableCards[random.nextInt(availableCards.length)];
    availableCards.remove(firstCardIndex);
    int secondCardIndex = availableCards[random.nextInt(availableCards.length)];
    return [firstCardIndex, secondCardIndex];
  }

  List<int> _mediumLogic(List<int> availableCards) {
    Random random = Random();

    // Check for a known match with a chance to make an educated guess
    if (random.nextDouble() < 0.15) { // 15% chance to make an educated guess
      List<int>? match = _findFirstMatch(availableCards);
      if (match != null) {
        return match; // If a match is found, select it
      }
    }

    // Fallback to random selection
    return _selectRandomCards(availableCards);
  }

  List<int> _hardLogic(List<int> availableCards) {
    Random random = Random();

    // Check for a known match with higher probability
    List<int>? match = _findFirstMatch(availableCards);

    if (match != null) {
      if (random.nextDouble() < 0.8) { // Increased chance to pick a known match
        return match;
      }

      // If we didn't pick the match, let's try to remember more cards
      List<int>? secondaryMatch = _findSecondaryMatch(availableCards);
      if (secondaryMatch != null && random.nextDouble() < 0.5) {
        return secondaryMatch; // Chance to pick another known pair
      }
    }

    // Fallback to random selection if no matches found or not selected
    return _selectRandomCards(availableCards);
  }

// Helper function to find the first known match among available cards
  List<int>? _findFirstMatch(List<int> availableCards) {
    Map<String, int> seenCards = {};

    for (int index in availableCards) {
      String cardImage = cardImages[index];
      if (seenCards.containsKey(cardImage)) {
        return [seenCards[cardImage]!, index];
      } else {
        seenCards[cardImage] = index;
      }
    }

    return null;
  }

// Helper function to find a secondary known match among available cards
  List<int>? _findSecondaryMatch(List<int> availableCards) {
    Map<String, int> seenPairs = {};

    for (int index in availableCards) {
      String cardImage = cardImages[index];
      if (seenPairs.containsKey(cardImage)) {
        return [seenPairs[cardImage]!, index];
      } else {
        seenPairs[cardImage] = index;
      }
    }

    return null;
  }
}
