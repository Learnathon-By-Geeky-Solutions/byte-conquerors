import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';
import 'package:soul_space/components/universal_large_button.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/additional_info/presentation/pages/additional_info_page.dart';
import 'package:soul_space/features/auth/presentation/signin/pages/sign_in_page.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_event.dart';
import 'package:soul_space/features/auth/presentation/signup/bloc/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _mailTextController = TextEditingController();
  final TextEditingController _passWordTextontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: TextStyle(
                  color: AppColors.lightGreyFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              },
              child: Text("Sign In",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdditionalInfoPage()),
            );
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Sign Up",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ReusableTextFormField(
                    hintText: "Enter your name ",
                    controller: _nameTextController,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 8),
                  ReusableTextFormField(
                    hintText: "Enter your email ",
                    controller: _mailTextController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  ReusableTextFormField(
                    hintText: "Enter your password ",
                    controller: _passWordTextontroller,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  UniversalLargeButton(
                    buttonText:
                        state is SignUpLoading ? "LOADING..." : "SIGN UP",
                    onTap: state is SignUpLoading
                        ? null
                        : () {
                            final email = _mailTextController.text;
                            final password = _passWordTextontroller.text;
                            final name = _nameTextController.text;

                            if (!email.contains('@') || password.length < 8) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    !email.contains('@')
                                        ? 'Invalid email format'
                                        : 'Password must be at least 8 characters',
                                  ),
                                ),
                              );
                              return;
                            }

                            context.read<SignUpBloc>().add(SignUpSubmitted(
                                name: name, email: email, password: password));
                          },
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     const Expanded(
                  //       child: Divider(
                  //           thickness: 2, color: AppColors.lightGreyFont),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: 8.0, vertical: 8.0),
                  //       child: Text("Or Sign Up with",
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             color: AppColors.lightGreyFont,
                  //             fontWeight: FontWeight.w600,
                  //           )),
                  //     ),
                  //     const Expanded(
                  //       child: Divider(
                  //           thickness: 2, color: AppColors.lightGreyFont),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     OutlinedIconButton(
                  //       buttonText: "Google",
                  //       buttionIcon: Icons.g_mobiledata_sharp,
                  //       onTap: () {},
                  //     ),
                  //     const SizedBox(width: 10),
                  //     OutlinedIconButton(
                  //       buttonText: "Apple",
                  //       buttionIcon: Icons.apple,
                  //       onTap: () {},
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
