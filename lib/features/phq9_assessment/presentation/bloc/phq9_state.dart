import '../../data/models/phq9_question_model.dart';

abstract class Phq9State {}

class Phq9InitialState extends Phq9State {}

class Phq9QuestionState extends Phq9State {
  final int currentIndex;
  final Phq9QuestionModel currentQuestion;
  final List<Phq9QuestionModel> questions;

  Phq9QuestionState({
    required this.currentIndex,
    required this.currentQuestion,
    required this.questions,
  });
}

class Phq9ResultState extends Phq9State {
  final int totalScore;
  final String severity;

  Phq9ResultState({required this.totalScore, required this.severity});
}
