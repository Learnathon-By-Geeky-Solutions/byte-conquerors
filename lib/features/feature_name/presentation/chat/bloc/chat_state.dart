import 'package:equatable/equatable.dart';
import 'package:soul_space/features/feature_name/presentation/chat/model/message_model.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;
  final bool isTyping;

  ChatLoaded({required this.messages, required this.isTyping});

  @override
  List<Object?> get props => [messages, isTyping];
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);

  @override
  List<Object?> get props => [error];
}
