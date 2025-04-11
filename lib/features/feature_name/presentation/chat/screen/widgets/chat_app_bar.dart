import 'package:flutter/material.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
