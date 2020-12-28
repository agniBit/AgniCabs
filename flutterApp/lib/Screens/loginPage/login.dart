import 'package:flutter/material.dart';
import 'package:testing/Screens/loginPage/components/background.dart';
import 'components/body.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Background(
        child: SafeArea(
          child: Body(),
        ),
      )
    );
  }
}
