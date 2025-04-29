import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soul_space/features/gemini_prompts/data/repositories/gemini_repository.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final GeminiRepository repository;

  GeminiBloc(this.repository) : super(GeminiInitial()) {
    on<GeminiPromptSelected>(_onPromptSelected);
  }

  Future<void> _onPromptSelected(
    GeminiPromptSelected event,
    Emitter<GeminiState> emit,
  ) async {
    emit(GeminiLoading());

    try {
      final response = await repository.getGeminiResponse(event.prompt);
      emit(GeminiLoaded(response));
    } catch (e) {
      emit(GeminiError("Failed to get response: ${e.toString()}"));
    }
  }
}
