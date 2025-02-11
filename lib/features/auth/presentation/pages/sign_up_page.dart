import 'package:flutter/material.dart';
import 'package:soul_space/components/outlined_icon_button.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';
import 'package:soul_space/components/universal_large_button.dart';
import 'package:soul_space/core/config/theme/app_colors.dart';
import 'package:soul_space/features/auth/presentation/pages/sign_in_page.dart';

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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  color: AppColors.lightGreyFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
                child: Text(
                  "Sign In",
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Row(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableTextFormField(
                  hintText: "Enter your name ",
                  controller: _nameTextController,
                  keyboardType: TextInputType.name,
                ),
                ReusableTextFormField(
                  hintText: "Enter your email ",
                  controller: _mailTextController,
                  keyboardType: TextInputType.emailAddress,
                ),
                ReusableTextFormField(
                  hintText: "Enter your password ",
                  controller: _passWordTextontroller,
                  keyboardType: TextInputType.visiblePassword,
                ),
                UniversalLargeButton(
                  buttonText: "SIGN UP",
                  onTap: () {},
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: AppColors.lightGreyFont,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        "Or Sign Up with",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.lightGreyFont,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: AppColors.lightGreyFont,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlinedIconButton(
                      buttonText: "Google",
                      buttionIcon: Icons.g_mobiledata_sharp,
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedIconButton(
                      buttonText: "Apple",
                      buttionIcon: Icons.apple,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
