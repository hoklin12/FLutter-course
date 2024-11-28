import 'question.dart';
import 'answer.dart';

class Submission {
  final Map<Question, Answer> _answers = {};

  int getScore() {
    int score = 0;
    _answers.forEach((question, answer) {
      if (answer.isCorrect()) {
        score++;
      }
    });
    return score;
  }

  void addAnswer(Question question, Answer answer) {
    _answers[question] = answer;
  }

  Answer? getAnswerFor(Question question) {
    return _answers[question];
  }

  void clear() {
    _answers.clear();
  }

  // Public getter to access answers
  Map<Question, Answer> get answers => _answers;
}
