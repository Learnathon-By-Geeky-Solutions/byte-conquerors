import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:soul_space/features/feature_name/presentation/chat/model/message_model.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GenerativeModel _model;
  late final ChatSession _chat;
  final List<Message> _messages = [];

  ChatBloc(this._model) : super(ChatInitial()) {
    _chat = _model.startChat();

    on<SendMessageEvent>((event, emit) async {
      _messages.add(Message(event.text, true));
      emit(ChatLoaded(messages: List.from(_messages), isTyping: true));

      try {
        final response = await _chat.sendMessage(Content.text(event.text));
        final botResponse = response.text ?? 'No response';
        _messages.add(Message(botResponse, false));
        emit(ChatLoaded(messages: List.from(_messages), isTyping: false));
      } catch (e) {
        emit(ChatError(e.toString()));
        emit(ChatLoaded(messages: List.from(_messages), isTyping: false));
      }
    });
  }
}
