import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMicTap;
  final VoidCallback onSendTap;
  final bool isListening;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onMicTap,
    required this.onSendTap,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Type a message...'),
              onSubmitted: (_) => onSendTap(),
            ),
          ),
          IconButton(
            icon: Icon(isListening ? Icons.mic_off : Icons.mic,
                color: isListening ? Colors.red : null),
            onPressed: onMicTap,
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSendTap,
          ),
        ],
      ),
    );
  }
}
