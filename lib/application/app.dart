import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/application/app_view2.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_bloc.dart';

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
      ],
      child: const SoulSpaceApp(),
    );
  }
}
