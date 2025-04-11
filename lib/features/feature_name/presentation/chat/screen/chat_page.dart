import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_bloc.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_event.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_state.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/typing_bubble.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    await _speech.initialize();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    context.read<ChatBloc>().add(SendMessageEvent(text));
    _controller.clear();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          if (result.finalResult) {
            _sendMessage(result.recognizedWords);
            setState(() => _isListening = false);
          }
        });
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _speech.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // Handle side effects such as errors or success messages
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $state')),
            );
          }
        },
        builder: (context, state) {
          final messages = (state is ChatLoaded) ? state.messages : [];
          final isTyping = (state is ChatLoaded) ? state.isTyping : false;

          // Scroll to the bottom when new messages are added
          if (_scrollController.hasClients) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            });
          }

          return Column(
            children: [
              // Custom AppBar
              Container(
                height: kToolbarHeight + 12,
                padding: const EdgeInsets.only(top: 22),
                width: double.infinity,
                color: AppColors.primaryColor,
                alignment: Alignment.center,
                child: const Text(
                  'Soul Space Voice Chat',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Divider(height: 1),

              // Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12.0),
                  itemCount: messages.length + (isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isTyping && index == messages.length) {
                      return const TypingBubble();
                    }
                    final msg = messages[index];
                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: msg.isUser ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(height: 1),

              // Input Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                            hintText: 'Type a message...'),
                        onSubmitted: (text) {
                          _sendMessage(text);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                      onPressed:
                          _isListening ? _stopListening : _startListening,
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
