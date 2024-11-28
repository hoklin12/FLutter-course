import 'package:new_flutter_app/MicroProject/model/Answer.dart';
import 'question.dart';

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

  void removeAnswers() {
    _answers.clear();
  }
}
