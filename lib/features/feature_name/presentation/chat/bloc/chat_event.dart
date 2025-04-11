import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String text;

  const SendMessageEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class StartListeningEvent extends ChatEvent {}

class StopListeningEvent extends ChatEvent {}

class SpeechResultEvent extends ChatEvent {
  final String text;

  const SpeechResultEvent(this.text);

  @override
  List<Object?> get props => [text];
}

class ToggleSpeakingEvent extends ChatEvent {
  final String text;

  const ToggleSpeakingEvent(this.text);

  @override
  List<Object?> get props => [text];
}
