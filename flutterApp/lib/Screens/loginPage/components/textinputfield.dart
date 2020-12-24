import 'package:flutter/material.dart';
import 'package:login_app/const.dart';

class Textinputfiel extends StatelessWidget {
  final Widget child;
  const Textinputfiel({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: size.width * .8,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primarycolorlight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
