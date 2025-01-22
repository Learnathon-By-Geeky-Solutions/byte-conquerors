import 'package:flutter/material.dart';
import 'package:soul_space/components/reusable_text_from_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _mailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'LogIn Screen',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 50,
              ),
              ReusableTextFormField(
                hintText: 'Enter your email',
                controller: _mailTEController,
                keyboardType: TextInputType.emailAddress,
                showLabelText: true,
                onChanged: (_) {},
              ),
              ReusableTextFormField(
                hintText: 'Enter your password',
                controller: _passwordTEController,
                keyboardType: TextInputType.visiblePassword,
                showLabelText: true,
                onChanged: (_) {},
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
