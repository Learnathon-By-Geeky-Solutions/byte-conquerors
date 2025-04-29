import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:soul_space/application/app_start/bloc/app_start_bloc.dart';
import 'package:soul_space/application/app_view.dart';
import 'package:soul_space/application/navigation/bloc/navigation_bloc.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:soul_space/features/gemini_prompts/data/repositories/gemini_repository.dart';
import 'package:soul_space/features/gemini_prompts/presentation/bloc/gemini_bloc.dart';
import 'package:soul_space/features/phq9_assessment/presentation/bloc/phq9_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Phq9Bloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository: AuthServiceRepository())),
        BlocProvider(create: (_) => AppStartBloc()..add(CheckAppStart())),
        BlocProvider(
          create: (context) {
            final apiKey = dotenv.env['AI_API_KEY']!;
            final model =
                GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
            final repo = GeminiRepository(model);
            return GeminiBloc(repo);
          },
        ),
      ],
      child: const SoulSpaceApp(),
    );
  }
}
