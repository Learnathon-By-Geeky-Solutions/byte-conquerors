import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_bloc.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_event.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_state.dart';
import 'package:soul_space/features/feature_name/presentation/chat/screen/widgets/typing_bubble.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  bool _isListening = false;
  bool _isSpeaking = false;
  bool _speechInitialized = false;
  bool _ttsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeSpeechToText();
    _initializeTextToSpeech();
  }

  // Initialize speech to text with better error handling
  Future<void> _initializeSpeechToText() async {
    debugPrint('Initializing speech to text...');
    try {
      _speechInitialized = await _speechToText.initialize(
        onStatus: (status) {
          debugPrint('Speech status: $status');
          // Handle status changes if needed
          if (status == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (error) {
          debugPrint('Speech error: ${error.errorMsg}');
          setState(() {
            _isListening = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Speech error: ${error.errorMsg}')),
            );
          }
        },
        debugLogging: true,
      );

      debugPrint('Speech to text initialized: $_speechInitialized');

      if (!_speechInitialized && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to initialize speech recognition')),
        );
      }
    } catch (e) {
      debugPrint('Exception during speech to text initialization: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing speech: $e')),
        );
      }
      _speechInitialized = false;
    }
  }

  // Initialize text to speech with better error handling
  Future<void> _initializeTextToSpeech() async {
    debugPrint('Initializing text to speech...');
    try {
      // Set initial configurations
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);

      // Add proper listeners for TTS events
      _flutterTts.setStartHandler(() {
        debugPrint("TTS started");
        setState(() {
          _isSpeaking = true;
        });
      });

      _flutterTts.setCompletionHandler(() {
        debugPrint("TTS completed");
        setState(() {
          _isSpeaking = false;
        });
      });

      _flutterTts.setErrorHandler((error) {
        debugPrint("TTS error: $error");
        setState(() {
          _isSpeaking = false;
        });
      });

      _flutterTts.setCancelHandler(() {
        debugPrint("TTS cancelled");
        setState(() {
          _isSpeaking = false;
        });
      });

      // Check if the engine is available
      var engines = await _flutterTts.getEngines;
      if (engines != null && engines.isNotEmpty) {
        debugPrint('Available TTS engines: $engines');
        _ttsInitialized = true;
      } else {
        debugPrint('No TTS engines available');
        _ttsInitialized = false;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No text-to-speech engines available')),
          );
        }
      }
    } catch (e) {
      debugPrint('Exception during text to speech initialization: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error initializing text-to-speech: $e')),
        );
      }
      _ttsInitialized = false;
    }
  }

  // Send message function
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    debugPrint('Sending message: $text');
    context.read<ChatBloc>().add(SendMessageEvent(text));
    _controller.clear();

    // Scroll to bottom after sending a message
    _scrollToBottom();
  }

  // Scroll functionality
  void _scrollToBottom() {
    // Use a delayed callback to ensure the list has been built
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Enhanced speech-to-text function
  void _startListening() async {
    debugPrint('Attempting to start listening...');

    if (_isListening) {
      debugPrint('Already listening, stopping...');
      _stopListening();
      return;
    }

    if (!_speechInitialized) {
      debugPrint('Speech not initialized, trying to initialize again...');
      bool success = await _speechToText.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: ${error.errorMsg}'),
        debugLogging: true,
      );

      if (!success) {
        debugPrint('Failed to initialize speech recognition');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to initialize speech recognition')),
          );
        }
        return;
      }

      _speechInitialized = success;
    }

    if (_speechInitialized) {
      debugPrint('Starting speech recognition...');

      // Check if we can listen right now
      if (_speechToText.isAvailable && !_speechToText.isListening) {
        setState(() => _isListening = true);

        try {
          await _speechToText.listen(
            onResult: (result) {
              debugPrint(
                  'Speech result: ${result.recognizedWords}, final: ${result.finalResult}');
              if (result.finalResult && result.recognizedWords.isNotEmpty) {
                _sendMessage(result.recognizedWords);
                setState(() => _isListening = false);
              }
            },
            listenFor: const Duration(seconds: 30),
            pauseFor: const Duration(seconds: 3),
            partialResults: true,
            cancelOnError: false,
            listenMode: stt.ListenMode.confirmation,
          );
          debugPrint('Listening started successfully');
        } catch (e) {
          debugPrint('Error in speech recognition listening: $e');
          setState(() => _isListening = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error with speech recognition: $e')),
            );
          }
        }
      } else {
        debugPrint('Speech is not available or already listening');
        setState(() => _isListening = false);
      }
    }
  }

  // Stop listening
  void _stopListening() {
    debugPrint('Stopping speech recognition...');
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
    setState(() => _isListening = false);
  }

  // Speak text function
  Future<void> _speakText(String text) async {
    if (!_ttsInitialized) {
      debugPrint('TTS not initialized, trying to initialize...');
      await _initializeTextToSpeech();
      if (!_ttsInitialized) {
        debugPrint('Failed to initialize TTS');
        return;
      }
    }

    if (_isSpeaking) {
      debugPrint('TTS is already speaking, stopping...');
      await _flutterTts.stop();
      setState(() => _isSpeaking = false);
      return;
    }

    if (text.isNotEmpty) {
      debugPrint('Speaking text: $text');
      try {
        var result = await _flutterTts.speak(text);
        debugPrint('TTS speak result: $result');
        if (result == 1) {
          setState(() => _isSpeaking = true);
        }
      } catch (e) {
        debugPrint('Error in TTS: $e');
        setState(() => _isSpeaking = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error with text-to-speech: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _speechToText.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // Handle side effects such as errors
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }

          // Scroll to bottom when state changes
          if (state is ChatLoaded) {
            _scrollToBottom();

            // If a bot message was just received, speak it
            // This assumes your ChatState has a way to indicate new messages
            // You might need to modify this based on your actual implementation
            if (state.messages.isNotEmpty && !state.messages.last.isUser) {
              // Uncomment this if you want automatic TTS for bot responses
              // _speakText(state.messages.last.text);
            }
          }
        },
        builder: (context, state) {
          final messages = (state is ChatLoaded) ? state.messages : [];
          final isTyping = (state is ChatLoaded) ? state.isTyping : false;

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
                      child: InkWell(
                        onTap: !msg.isUser ? () => _speakText(msg.text) : null,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.isUser ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  msg.text,
                                  style: TextStyle(
                                    color: msg.isUser
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              if (!msg.isUser)
                                IconButton(
                                  icon: Icon(
                                    _isSpeaking
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    size: 16,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () => _speakText(msg.text),
                                ),
                            ],
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
                      icon: Icon(_isListening ? Icons.mic_off : Icons.mic,
                          color: _isListening ? Colors.red : null),
                      onPressed: _startListening,
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
