import 'package:flutter/material.dart';
import 'package:login_app/Screens/map/components/background.dart';
import 'package:login_app/Screens/map/components/body.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class mapSearchScreen extends StatelessWidget {
  const mapSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: background(child: Body())
    );
  }
}
