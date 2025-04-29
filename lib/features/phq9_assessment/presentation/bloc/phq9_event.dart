import 'package:equatable/equatable.dart';

abstract class Phq9Event extends Equatable {
  @override
  List<Object> get props => [];
}

class Phq9Started extends Phq9Event {}

class AnswerSelected extends Phq9Event {
  final int selectedOption;

  AnswerSelected(this.selectedOption);

  @override
  List<Object> get props => [selectedOption];
}

class NextQuestionPressed extends Phq9Event {}

class Phq9Restarted extends Phq9Event {}
