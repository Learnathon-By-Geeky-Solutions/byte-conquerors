import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:soul_space/application/app_view2.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:soul_space/features/feature_name/presentation/chat/bloc/chat_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignUpBloc(authRepository: AuthServiceRepository()),
        ),
        BlocProvider(
          create: (context) {
            final apiKey = dotenv.env['AI_API_KEY']!;
            final model =
                GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
            return ChatBloc(model);
          },
        ),
      ],
      child: const SoulSpaceApp(),
    );
  }
}
