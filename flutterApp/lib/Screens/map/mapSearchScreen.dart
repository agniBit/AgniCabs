import 'package:flutter/material.dart';
import 'package:testing/Screens/appDrawer/appDrawer.dart';
import 'package:testing/Screens/map/components/body.dart';

class MapSearchScreen extends StatelessWidget {
  const MapSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Background(),
          ],
        ),
      ),
    );
  }
}
