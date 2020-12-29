import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testing/const.dart';

class InputTextBoxData {
  String inputText = '';
  bool isFucused = false;
}

// ignore: must_be_immutable
class SearchBox extends StatefulWidget {
  SearchBox({
    Key key,
    @required this.size,
    @required this.hintText,
    this.streamController,
  }) : super(key: key) {
    data = InputTextBoxData();
    streamController.add(data);
  }

  final Size size;
  final String hintText;
  final StreamController streamController;
  InputTextBoxData data;

  notifyToBuilder() {
    streamController.add(data);
  }

  @override
  _SearchBoxState createState() => _SearchBoxState();

  String getInputText() {
    return _SearchBoxState().inputText;
  }
}

class _SearchBoxState extends State<SearchBox> {
  String inputText;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: widget.size.width,
      margin: EdgeInsets.symmetric(
          vertical: 5, horizontal: widget.size.width * .08),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        boxShadow: [
          BoxShadow(
            color: Colors.purple[500],
            offset: Offset(.3,1),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (text) {
          widget.data.inputText = text;
          widget.notifyToBuilder();
        },
        onEditingComplete: () {
          widget.data.isFucused = false;
          widget.notifyToBuilder();
        },
        onTap: () {
          widget.data.isFucused = true;
          widget.notifyToBuilder();
        },
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
