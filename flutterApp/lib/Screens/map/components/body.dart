import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:testing/Screens/map/components/addrSuggestionsWidget.dart';
import 'package:testing/Screens/map/components/displayLiveLocation.dart';
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

  // void getlocationPerm() async {
  //   final location = Location();
  //   final hasPermissions = await location.hasPermission();
  //   if (hasPermissions != PermissionStatus.GRANTED) {
  //     await location.requestPermission();
  //   }
  // }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: close_sinks
    StreamController addrStreamController = new StreamController();
    Stream addrStream = addrStreamController.stream;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          // child: Container(),
          child: DisplayLiveLOcation(),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 120,
            width: size.width,
            color: Colors.black.withOpacity(.7),
            child: Row(
              children: [
                Container(
                  width: size.width * .2,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: size.width * .10,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                // AppDrawer(),
                Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    SearchBox(
                      size: size,
                      hintText: 'from',
                      streamController: addrStreamController,
                      isDestinationAddrInput: false,
                    ),
                    SearchBox(
                      size: size,
                      hintText: 'to',
                      streamController: addrStreamController,
                      isDestinationAddrInput: true,
                    ),
                  ],
                ),
              ],
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
            height: 80,
            width: size.width,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(.7),
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
                          return Colors.green[700];
                        return Colors
                            .deepPurple; // Use the component's default.
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
        ),
      ],
    );
  }
}
