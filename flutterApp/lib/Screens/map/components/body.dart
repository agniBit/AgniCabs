import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:testing/Screens/map/components/DisplayMapWithRoute.dart';
import 'package:testing/Screens/map/components/addrSuggestionsWidget.dart';
import 'package:testing/Screens/map/components/searchBox.dart';

class Background extends StatefulWidget {
  Background({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _BackgroundState createState() => _BackgroundState(this.child);
}

class _BackgroundState extends State<Background> {
  _BackgroundState(this.child);
  final Widget child;
  void getlocationPerm() async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.GRANTED) {
      await location.requestPermission();
    }
  }

  @override
  initState() {
    super.initState();
    getlocationPerm();
  }

  var routePoints;
  String origin = '79.9188,27.05524';
  String destination = '80.915661,26.8660711';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: close_sinks
    StreamController fromAddrStreamController = new StreamController();
    // ignore: close_sinks
    StreamController toAddrStreamController = new StreamController();
    Stream fromAddrStream = fromAddrStreamController.stream;
    Stream toAddrStream = toAddrStreamController.stream;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.red,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // DisplayMapWithRoute(origin: origin, destination: destination),
          Column(
            children: [
              SizedBox(
                height: 5,
              ),
              SearchBox(
                size: size,
                hintText: 'from',
                streamController: fromAddrStreamController,
              ),
              SearchBox(
                size: size,
                hintText: 'to',
                streamController: toAddrStreamController,
              ),
            ],
          ),
          AddrSuggestionsWidget(stream: fromAddrStream, size: size, position: 50,),
          AddrSuggestionsWidget(stream: toAddrStream, size: size, position: 95),
        ],
      ),
    );
  }
}
