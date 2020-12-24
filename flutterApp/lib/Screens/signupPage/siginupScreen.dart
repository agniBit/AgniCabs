import 'package:flutter/material.dart';
import 'package:login_app/Screens/signupPage/components/body.dart';
import 'package:login_app/Screens/signupPage/components/background.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(child: Body(),),
    );
  }
}
