import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String text;

  SendMessageEvent(this.text);

  @override
  List<Object?> get props => [text];
}
