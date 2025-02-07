import 'package:flutter/material.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';
import 'package:soul_space/components/universal_large_button.dart';

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
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Column(
          spacing: 15,
          mainAxisSize: MainAxisSize.min,
          children: [
            ReusableTextFormField(
              hintText: "Enter your name ",
              controller: _nameTextController,
              keyboardType: TextInputType.name,
            ),
            ReusableTextFormField(
              hintText: "Enter your name ",
              controller: _mailTextController,
              keyboardType: TextInputType.emailAddress,
            ),
            ReusableTextFormField(
              hintText: "Enter your name ",
              controller: _passWordTextontroller,
              keyboardType: TextInputType.visiblePassword,
            ),
            UniversalLargeButton(
              buttonText: "Sign Up",
              onTap: () {},
            )
          ],
        ),
      ),
    ));
  }
}
