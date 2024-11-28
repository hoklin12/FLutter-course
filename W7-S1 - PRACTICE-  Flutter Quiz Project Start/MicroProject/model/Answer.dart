class Answer {
  final String value; // The user's answer
  final String correctAnswer; // The correct answer for the question

  Answer(this.value, this.correctAnswer);

  bool isCorrect() {
    return value == correctAnswer;
  }
}
