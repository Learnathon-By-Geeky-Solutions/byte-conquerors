import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/constants/phq9_questions_list.dart';

import '../../data/datasources/phq9_firebase_service.dart';
import '../../data/models/phq9_question_model.dart';
import 'phq9_event.dart';
import 'phq9_state.dart';

class Phq9Bloc extends Bloc<Phq9Event, Phq9State> {
  final _firebaseService = Phq9FirebaseService();
  List<Phq9QuestionModel> _questions = [];

  Phq9Bloc() : super(Phq9InitialState()) {
    on<Phq9Started>((event, emit) {
      _questions = phq9Questions
          .map((q) => Phq9QuestionModel(questionText: q.questionText))
          .toList();

      emit(Phq9QuestionState(
        currentIndex: 0,
        currentQuestion: _questions[0],
        questions: _questions,
      ));
    });

    on<AnswerSelected>((event, emit) {
      if (state is Phq9QuestionState) {
        final currentState = state as Phq9QuestionState;
        _questions[currentState.currentIndex].selectedOption =
            event.selectedOption;

        emit(Phq9QuestionState(
          currentIndex: currentState.currentIndex,
          currentQuestion: _questions[currentState.currentIndex],
          questions: List.from(_questions),
        ));
      }
    });

    on<NextQuestionPressed>((event, emit) async {
      if (state is Phq9QuestionState) {
        final currentState = state as Phq9QuestionState;
        final currentQuestion = _questions[currentState.currentIndex];

        if (currentQuestion.selectedOption == -1) return;

        if (currentState.currentIndex < _questions.length - 1) {
          emit(Phq9QuestionState(
            currentIndex: currentState.currentIndex + 1,
            currentQuestion: _questions[currentState.currentIndex + 1],
            questions: List.from(_questions),
          ));
        } else {
          final totalScore =
              _questions.fold(0, (sum, q) => sum + q.selectedOption);
          final severity = _determineSeverity(totalScore);

          emit(Phq9ResultState(totalScore: totalScore, severity: severity));
          await _firebaseService.savePhq9Score(totalScore);
        }
      }
    });

    on<Phq9Restarted>((event, emit) {
      if (_questions.isEmpty) return; // Prevents late access

      for (var q in _questions) {
        q.selectedOption = -1;
      }
      emit(Phq9InitialState());
    });
  }

  String _determineSeverity(int score) {
    if (score <= 4) return 'Minimal';
    if (score <= 9) return 'Mild';
    if (score <= 14) return 'Moderate';
    if (score <= 19) return 'Moderately Severe';
    return 'Severe';
  }
}
