import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';
import 'package:soul_space/components/universal_large_button.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/auth/data/repositories/auth_repository.dart';
import 'package:soul_space/features/auth/presentation/signin/bloc/sign_in_bloc.dart';
import 'package:soul_space/features/auth/presentation/signin/bloc/sign_in_event.dart';
import 'package:soul_space/features/auth/presentation/signin/bloc/sign_in_state.dart';
import 'package:soul_space/features/auth/presentation/signup/pages/sign_up_page.dart';
import 'package:soul_space/features/bottom_nav/bottom_nav_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _mailTextController = TextEditingController();
  final TextEditingController _passWordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(authService: AuthServiceRepository()),
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is SignInSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const BottomNavScreen()),
            );
          }
        },
        child: Scaffold(
          bottomNavigationBar: _buildBottomNav(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ReusableTextFormField(
                      hintText: "Enter your email ",
                      controller: _mailTextController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 8),
                    ReusableTextFormField(
                      hintText: "Enter your password ",
                      controller: _passWordTextController,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return UniversalLargeButton(
                          buttonText:
                              state is SignInLoading ? "LOADING..." : "SIGN IN",
                          onTap: state is SignInLoading
                              ? null
                              : () {
                                  final email = _mailTextController.text.trim();
                                  final password =
                                      _passWordTextController.text.trim();

                                  if (!isValidEmail(email) ||
                                      password.length < 8) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          !isValidEmail(email)
                                              ? 'Invalid email format'
                                              : 'Password must be at least 8 characters long',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  context.read<SignInBloc>().add(
                                        SignInButtonPressed(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    // _buildDivider(),
                    // const SizedBox(height: 10),
                    // _buildSocialButtons()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      color: AppColors.lightBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: AppColors.lightGreyFont,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignUpPage()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildDivider() {
//   return Row(
//     children: [
//       const Expanded(
//         child: Divider(thickness: 2, color: AppColors.lightGreyFont),
//       ),
//       const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.0),
//         child: Text(
//           "Or Sign In with",
//           style: TextStyle(
//             fontSize: 14,
//             color: AppColors.lightGreyFont,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       const Expanded(
//         child: Divider(thickness: 2, color: AppColors.lightGreyFont),
//       )
//     ],
//   );
// }

// Widget _buildSocialButtons() {
//   return Row(
//     children: [
//       OutlinedIconButton(
//         buttonText: "Google",
//         buttionIcon: Icons.g_mobiledata_sharp,
//         onTap: () {},
//       ),
//       const SizedBox(width: 10),
//       OutlinedIconButton(
//         buttonText: "Apple",
//         buttionIcon: Icons.apple,
//         onTap: () {},
//       ),
//     ],
//   );
// }
}
