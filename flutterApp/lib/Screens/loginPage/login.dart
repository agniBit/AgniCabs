import 'package:flutter/material.dart';
import 'components/body.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
