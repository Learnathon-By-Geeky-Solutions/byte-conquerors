part of 'gemini_bloc.dart';

abstract class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

class GeminiInitial extends GeminiState {}

class GeminiLoading extends GeminiState {}

class GeminiLoaded extends GeminiState {
  final String response;

  const GeminiLoaded(this.response);

  @override
  List<Object> get props => [response];
}

class GeminiError extends GeminiState {
  final String message;

  const GeminiError(this.message);

  @override
  List<Object> get props => [message];
}
