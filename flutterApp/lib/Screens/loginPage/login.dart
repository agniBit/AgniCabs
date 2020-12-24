import 'package:flutter/material.dart';
import 'package:login_app/Screens/loginPage/components/background.dart';
import 'components/body.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Background(child: Body(),),
    );
  }
}
