part of 'gemini_bloc.dart';

abstract class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object> get props => [];
}

class GeminiPromptSelected extends GeminiEvent {
  final String prompt;

  const GeminiPromptSelected(this.prompt);

  @override
  List<Object> get props => [prompt];
}
