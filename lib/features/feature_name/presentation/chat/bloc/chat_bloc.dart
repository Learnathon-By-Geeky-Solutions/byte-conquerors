import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'chat_event.dart';
import 'chat_state.dart';
import '../model/message_model.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GenerativeModel _model;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  late final ChatSession _chat;
  bool _speechInitialized = false;

  ChatBloc(this._model) : super(const ChatState()) {
    _chat = _model.startChat();

    _initTTS();
    _initSpeech();

    on<SendMessageEvent>(_onSendMessage);
    on<StartListeningEvent>(_onStartListening);
    on<StopListeningEvent>(_onStopListening);
    on<SpeechResultEvent>(_onSpeechResult);
    on<ToggleSpeakingEvent>(_onToggleSpeaking);
  }

  void _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    final updatedMessages = List<Message>.from(state.messages)
      ..add(Message(event.text, true));
    emit(state.copyWith(messages: updatedMessages, isTyping: true));

    try {
      final response = await _chat.sendMessage(Content.text(event.text));
      final botReply = response.text ?? 'No response';
      updatedMessages.add(Message(botReply, false));
      emit(state.copyWith(messages: updatedMessages, isTyping: false));
    } catch (_) {
      emit(state.copyWith(isTyping: false));
    }
  }

  void _onStartListening(
      StartListeningEvent event, Emitter<ChatState> emit) async {
    if (!_speechInitialized) return;

    emit(state.copyWith(isListening: true, currentSpeechText: ''));
    await _speechToText.listen(
      onResult: (result) {
        if (result.finalResult && result.recognizedWords.isNotEmpty) {
          add(SpeechResultEvent(result.recognizedWords));
          add(StopListeningEvent());
        }
      },
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
      cancelOnError: true,
    );
  }

  void _onStopListening(
      StopListeningEvent event, Emitter<ChatState> emit) async {
    await _speechToText.stop();
    emit(state.copyWith(isListening: false));
  }

  void _onSpeechResult(SpeechResultEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(currentSpeechText: event.text));
  }

  void _onToggleSpeaking(
      ToggleSpeakingEvent event, Emitter<ChatState> emit) async {
    if (state.isSpeaking) {
      await _flutterTts.stop();
      emit(state.copyWith(isSpeaking: false));
    } else {
      emit(state.copyWith(isSpeaking: true));
      await _flutterTts.speak(event.text);
      emit(state.copyWith(isSpeaking: false));
    }
  }

  void _initSpeech() async {
    _speechInitialized = await _speechToText.initialize(
      onStatus: (status) {
        if (status == 'notListening') add(StopListeningEvent());
      },
      onError: (_) => add(StopListeningEvent()),
    );
  }

  void _initTTS() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  @override
  Future<void> close() {
    _flutterTts.stop();
    _speechToText.stop();
    return super.close();
  }
}
