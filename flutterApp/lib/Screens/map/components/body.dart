import 'dart:async';
import 'dart:ui';
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
        (MediaQuery.of(context).viewInsets.bottom == 0)
            ? Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        print('open menu');
                      },
                      elevation:10,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    child: AddrSuggestionsWidget(
                      stream: addrStream,
                      size: size,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(.7),
                      child: Container(
                        // height: 120,
                        width: size.width * .85,
                        child: Column(
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
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(),
                  ),
                  Positioned(
                    top: 130,
                    child: AddrSuggestionsWidget(
                      stream: addrStream,
                      size: size,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(.7),
                      child: Container(
                        // height: 120,
                        width: size.width * .85,
                        child: Column(
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
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
