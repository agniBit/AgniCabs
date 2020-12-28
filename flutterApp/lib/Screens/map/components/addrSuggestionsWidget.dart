import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testing/Screens/map/mapBoxApiHelper/mapBoxApiHelper.dart';

class AddrSuggestionsWidget extends StatelessWidget {
  AddrSuggestionsWidget(
      {Key key,
      @required this.size,
      @required this.position,
      @required this.stream})
      : super(key: key) {
    placeDataStreamController = new StreamController.broadcast();
    placeDataStream = placeDataStreamController.stream;
  }
  final Stream stream;
  final Size size;
  final double position;
  StreamController placeDataStreamController;
  Stream placeDataStream;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position,
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.data != Null &&
              snapshot.data.isFucused &&
              snapshot.data.inputText.length > 0) {
            getMatchingLocations(
                snapshot.data.inputText, placeDataStreamController);
            return Container(
              height: 300,
              width: size.width * 0.9,
              color: Colors.green,
              child: StreamBuilder(
                stream: placeDataStream,
                builder:
                    (BuildContext contex, AsyncSnapshot placeDataSnapshot) {
                  if (placeDataSnapshot.hasData &&
                      placeDataSnapshot.data.length > 0) {
                    return Container(
                        color: Colors.yellow,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Text(placeDataSnapshot.data[index]);
                          },
                          itemCount: placeDataSnapshot.data.length,
                        ));
                  } else {
                    return Text("Searching");
                  }
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
