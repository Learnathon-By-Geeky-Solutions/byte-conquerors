import 'package:flutter/material.dart';
import 'package:soul_space/features/splash_screen/presentation/widgets/splash_blob.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashBlob(),
      ),
    );
  }
}
