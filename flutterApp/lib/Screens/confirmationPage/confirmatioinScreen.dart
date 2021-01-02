import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/body.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Body(),
    );
  }
}