import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/chat_app_bar.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/chat_bubble.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/chat_input_bar.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/typing_bubble.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  ChatPage({super.key});

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (!state.isTyping) _scrollToBottom();
          _textController.text = state.currentSpeechText;
        },
        builder: (context, state) {
          return Column(
            children: [
              const ChatAppBar(),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final msg = state.messages[index];
                    return ChatBubble(
                      msg: msg,
                      isSpeaking: state.isSpeaking,
                      onSpeak: () {
                        context
                            .read<ChatBloc>()
                            .add(ToggleSpeakingEvent(msg.text));
                      },
                    );
                  },
                ),
              ),
              if (state.isTyping) const TypingBubble(),
              const Divider(height: 1),
              ChatInputBar(
                controller: _textController,
                onMicTap: () =>
                    context.read<ChatBloc>().add(StartListeningEvent()),
                onSendTap: () {
                  final text = _textController.text.trim();
                  if (text.isNotEmpty) {
                    context.read<ChatBloc>().add(SendMessageEvent(text));
                    _textController.clear();
                  }
                },
                isListening: state.isListening,
              ),
            ],
          );
        },
      ),
    );
  }
}
