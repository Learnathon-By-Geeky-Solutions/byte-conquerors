import 'package:equatable/equatable.dart';
import '../model/message_model.dart';

class ChatState extends Equatable {
  final List<Message> messages;
  final bool isTyping;
  final bool isListening;
  final bool isSpeaking;
  final String currentSpeechText;

  const ChatState({
    this.messages = const [],
    this.isTyping = false,
    this.isListening = false,
    this.isSpeaking = false,
    this.currentSpeechText = '',
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isTyping,
    bool? isListening,
    bool? isSpeaking,
    String? currentSpeechText,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      isListening: isListening ?? this.isListening,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      currentSpeechText: currentSpeechText ?? this.currentSpeechText,
    );
  }

  @override
  List<Object?> get props =>
      [messages, isTyping, isListening, isSpeaking, currentSpeechText];
}
