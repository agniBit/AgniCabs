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
  bool openFromSuggestionWidget = true;
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

  void set closeOtherAddrSuggestionsWidget(bool value) {
    this.openFromSuggestionWidget = value;
  }

  var routePoints;
  String origin = '79.9188,27.05524';
  String destination = '80.915661,26.8660711';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: close_sinks
    StreamController addrStreamController = new StreamController();
    Stream addrStream = addrStreamController.stream;
    return Stack(
      alignment: Alignment.center,
      children: [
        DisplayMapWithRoute(origin: origin, destination: destination),
        Column(
          children: [
            SizedBox(
              height: 8,
            ),
            SearchBox(
              size: size,
              hintText: 'from',
              streamController: addrStreamController,
            ),
            SearchBox(
              size: size,
              hintText: 'to',
              streamController: addrStreamController,
            ),
            AddrSuggestionsWidget(
              stream: addrStream,
              size: size,
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          child: Container(
            height: 50,
            width: size.width * .85,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ElevatedButton(
                onPressed: () {
                  print('book button pressed');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.lightGreen;
                      return Colors.purple[500]; // Use the component's default.
                    },
                  ),
                ),
                child: Text(
                  "Book",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
