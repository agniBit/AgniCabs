import 'package:flutter/material.dart';
import 'package:login_app/const.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    Key key,
    @required this.size,
    @required this.hintText,
    @required this.icon,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final Icon icon;
  String inputText;

  @override
  Widget build(BuildContext context) {
    bool isPass = false;
    if (hintText == 'Password') {
      isPass = true;
    }
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: size.width * .8,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: primarycolorlight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        obscureText: isPass,
        onChanged: (text) {
          this.inputText = text;
        },
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
