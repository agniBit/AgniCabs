import 'dart:async';
import 'package:flutter/material.dart';

class InputTextBoxData {
  String inputText = '';
  bool isComplete;
  bool isDestinationAddrInput;
}

// ignore: must_be_immutable
class SearchBox extends StatefulWidget {
  SearchBox({
    Key key,
    @required this.size,
    @required this.hintText,
    @required this.isDestinationAddrInput,
    this.streamController,
  }) : super(key: key) {
    data = InputTextBoxData();
  }
  final bool isDestinationAddrInput;
  final Size size;
  final String hintText;
  final StreamController streamController;
  InputTextBoxData data;

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
          widget.data.isDestinationAddrInput = widget.isDestinationAddrInput;
          widget.data.isComplete = false;
          widget.data.inputText = text;
          widget.streamController.add(widget.data);
        },
        onTap: () {
          widget.streamController.add(widget.data);
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
