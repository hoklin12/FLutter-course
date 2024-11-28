import 'package:test/test.dart';
import 'package:new_flutter_app/MicroProject/model/submission.dart';
import 'package:new_flutter_app/MicroProject/model/question.dart';
import 'package:new_flutter_app/MicroProject/model/Answer.dart'; // Ensure this matches your file name

void main() {
  group('Answer Tests', () {
    test('Correct answer should return true', () {
      // Arrange
      final answer = Answer('Paris', 'Paris'); // Answer matches correct answer

      // Act
      final result = answer.isCorrect();

      // Assert
      expect(result, isTrue);
    });

    test('Incorrect answer should return false', () {
      // Arrange
      final answer = Answer('London', 'Paris'); // Answer does not match correct answer

      // Act
      final result = answer.isCorrect();

      // Assert
      expect(result, isFalse);
    });
  });

  group('Submission Tests', () {
    test('Add and retrieve answers', () {
      // Arrange
      final question = Question(
        title: 'What is Dart?',
        possibleAnswers: ['Programming Language', 'Food', 'Animal'],
        goodAnswer: 'Programming Language',
      );
      final submission = Submission();

      // Act
      submission.addAnswer(question, Answer('Programming Language', 'Programming Language'));

      // Assert
      expect(submission.getAnswerFor(question)?.isCorrect(), isTrue);
    });

    test('Get score for correct and incorrect answers', () {
      // Arrange
      final question1 = Question(
        title: 'What is Dart?',
        possibleAnswers: ['Programming Language', 'Food', 'Animal'],
        goodAnswer: 'Programming Language',
      );
      final question2 = Question(
        title: 'What is Flutter?',
        possibleAnswers: ['SDK', 'Game', 'Operating System'],
        goodAnswer: 'SDK',
      );
      final submission = Submission();

      // Act
      submission.addAnswer(question1, Answer('Programming Language', 'Programming Language'));
      submission.addAnswer(question2, Answer('SDK', 'Wrong Answer'));

      // Assert
      expect(submission.getScore(), 1); // Only the first answer is correct.
    });
  });
}

extension on Submission {
  getAnswerFor(Question question) {}
}
