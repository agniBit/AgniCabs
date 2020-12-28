import 'package:flutter/material.dart';
import 'package:testing/Screens/placeSearchPage.dart/components/Body.dart';

class PlaceSearchScreen extends StatefulWidget {
  PlaceSearchScreen({Key key}) : super(key: key);

  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
