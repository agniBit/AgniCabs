import 'package:flutter/material.dart';
import 'package:testing/Screens/map/components/background.dart';
import 'package:testing/Screens/map/components/body.dart';

class MapSearchScreen extends StatelessWidget {
  const MapSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Body(),
      ),
    );
  }
}
