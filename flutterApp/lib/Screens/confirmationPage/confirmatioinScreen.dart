import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/body.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen(
      {Key key, @required this.toAddrData, @required this.fromAddrData})
      : super(key: key);

  final toAddrData;
  final fromAddrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('AgniCabs'),
      ),
      body: Body(
        fromAddrData: fromAddrData,
        toAddrData: toAddrData,
      ),
    );
  }
}
