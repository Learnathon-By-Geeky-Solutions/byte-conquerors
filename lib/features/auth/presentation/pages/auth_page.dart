import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soul_space/features/auth/domain/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/pages/sign_in_page.dart';
import 'package:soul_space/features/profile/presentation/pages/profile_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServiceRepository _authRepository = AuthServiceRepository();
    final Stream<User?> getAuthChanged = _authRepository.authStateChanges;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: getAuthChanged,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return SignInPage();
            } else {
              return ProfilePage();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
