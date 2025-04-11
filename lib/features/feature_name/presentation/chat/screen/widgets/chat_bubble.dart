import 'package:flutter/material.dart';
import '../../model/message_model.dart';

class ChatBubble extends StatelessWidget {
  final Message msg;
  final bool isSpeaking;
  final VoidCallback onSpeak;

  const ChatBubble({
    super.key,
    required this.msg,
    required this.isSpeaking,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onTap: !msg.isUser ? onSpeak : null,
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
                    color: msg.isUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
              if (!msg.isUser)
                IconButton(
                  icon: Icon(
                    isSpeaking ? Icons.volume_off : Icons.volume_up,
                    size: 16,
                    color: Colors.grey[700],
                  ),
                  onPressed: onSpeak,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
