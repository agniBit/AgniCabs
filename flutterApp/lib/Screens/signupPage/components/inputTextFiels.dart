import 'package:flutter/material.dart';
import 'package:testing/const.dart';

class InputTextField extends StatefulWidget {
  InputTextField({
    Key key,
    @required this.size,
    @required this.hintText,
    @required this.icon,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final Icon icon;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();

  getInputText() {
    return _InputTextFieldState().inputText;
  }
}

class _InputTextFieldState extends State<InputTextField> {
  String inputText;

  @override
  Widget build(BuildContext context) {
    bool isPass = false;
    if (widget.hintText == 'Password') {
      isPass = true;
    }
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: widget.size.width * .8,
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
          icon: widget.icon,
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
