import 'package:flutter/material.dart';
import 'package:testing/Screens/signupPage/components/body.dart';
import 'package:testing/Screens/signupPage/components/background.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Background(
          child: Body(),
        ),
      ),
    );
  }
}
