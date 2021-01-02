import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/body.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key key, @required this.toAddrData, @required this.fromAddrData}) : super(key: key);

  final toAddrData;
  final fromAddrData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Body(fromAddrData: fromAddrData, toAddrData: toAddrData,),
    );
  }
}