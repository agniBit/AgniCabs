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
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerRight,
      height: 40,
      width: size.width * .8 - 20,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: TextField(
        onChanged: (text) {
          print('notify suggestion box');
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
        style: TextStyle(color: Colors.deepPurple),
        decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.deepPurple),
            hintText: widget.hintText,
            border: InputBorder.none,
            focusColor: Colors.deepPurple,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
