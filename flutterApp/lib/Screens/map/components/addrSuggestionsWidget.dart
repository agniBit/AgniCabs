import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testing/Screens/map/mapBoxApiHelper/mapBoxApiHelper.dart';

class AddrSuggestionsWidget extends StatelessWidget {
  AddrSuggestionsWidget({Key key, @required this.size, @required this.stream})
      : super(key: key) {
    placeDataStreamController = new StreamController.broadcast();
    placeDataStream = placeDataStreamController.stream;
  }
  final Stream stream;
  final Size size;
  // ignore: close_sinks
  StreamController placeDataStreamController;
  Stream placeDataStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData &&
            snapshot.data != Null &&
            MediaQuery.of(context).viewInsets.bottom != 0 &&
            snapshot.data.inputText.length > 0) {
          getMatchingLocations(
              snapshot.data.inputText, placeDataStreamController);
          return Container(
            constraints: BoxConstraints(maxHeight: size.height * .4),
            // height: size.height*.4,
            margin: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: MediaQuery.of(context).size.width * .08),
            color: Colors.transparent,
            child: StreamBuilder(
              stream: placeDataStream,
              builder: (BuildContext contex, AsyncSnapshot placeDataSnapshot) {
                if (placeDataSnapshot.hasData &&
                    placeDataSnapshot.data.length > 0) {
                  return ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(12),
                            color: index % 2 == 0
                                ? Colors.transparent
                                : Colors.grey[50].withOpacity(0.05),
                            child: Text(
                              placeDataSnapshot.data[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                        itemCount: placeDataSnapshot.data.length,
                      ),
                    ),
                  );
                } else {
                  return Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: Text("Searching"));
                }
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
