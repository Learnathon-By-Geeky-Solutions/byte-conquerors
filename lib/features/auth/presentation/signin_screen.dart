import 'package:flutter/material.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _mailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('LogIn Screen'),
              ReusableTextFormField(
                hintText: 'Enter your email',
                controller: _mailTEController,
                keyboardType: TextInputType.emailAddress,
                showLabelText: true,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
