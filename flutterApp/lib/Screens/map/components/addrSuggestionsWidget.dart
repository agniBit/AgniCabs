import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testing/Screens/confirmationPage/confirmatioinScreen.dart';
import 'package:testing/Screens/map/mapBoxApiHelper/mapBoxApiHelper.dart';
import 'package:latlong/latlong.dart';

class AddrData {
  bool isSet = false;
  String inputText;
  LatLng latLng;
}

class placeList {
  var name = [];
  var latlng = [];
}

class AddrSuggestionsWidget extends StatefulWidget {
  AddrSuggestionsWidget({Key key, @required this.size, @required this.stream})
      : super(key: key) {
    placeDataStreamController = new StreamController.broadcast();
    placeDataStream = placeDataStreamController.stream;
    fromAddrData = AddrData();
    toAddrData = AddrData();
  }
  final Stream stream;
  final Size size;
  // ignore: close_sinks
  StreamController placeDataStreamController;
  Stream placeDataStream;
  AddrData fromAddrData = AddrData();
  AddrData toAddrData = AddrData();

  @override
  _AddrSuggestionsWidgetState createState() => _AddrSuggestionsWidgetState();
}

class _AddrSuggestionsWidgetState extends State<AddrSuggestionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: widget.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('get data');
          print(snapshot.data);
          if (snapshot.hasData) {
            if (snapshot.hasData &&
                snapshot.data != Null &&
                MediaQuery.of(context).viewInsets.bottom != 0 &&
                snapshot.data.inputText.length > 0) {
              print('\n $snapshot.data.inputText');
              getMatchingLocations(
                  snapshot.data.inputText, widget.placeDataStreamController);
              return Container(
                width: widget.size.width,
                constraints:
                    BoxConstraints(maxHeight: widget.size.height * .35),
                margin: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: MediaQuery.of(context).size.width * .04),
                color: Colors.transparent,
                child: StreamBuilder(
                  stream: widget.placeDataStream,
                  builder:
                      (BuildContext contex, AsyncSnapshot placeDataSnapshot) {
                    if (placeDataSnapshot.hasData &&
                        placeDataSnapshot.data != Null) {
                      print(placeDataSnapshot.data.name);
                      print(placeDataSnapshot.data.latlng);
                    }
                    if (placeDataSnapshot.hasData &&
                        placeDataSnapshot.data != Null) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: placeDataSnapshot.data.name.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: InkWell(
                                onTap: () {
                                  var coord =
                                      placeDataSnapshot.data.latlng[index];
                                  if (snapshot.data.isDestinationAddrInput) {
                                    setState(() {
                                      widget.toAddrData.latLng =
                                          LatLng(coord[1], coord[0]);
                                      widget.toAddrData.inputText =
                                          snapshot.data.inputText;
                                      widget.toAddrData.isSet = true;
                                    });
                                  } else {
                                    setState(() {
                                      widget.fromAddrData.latLng =
                                          LatLng(coord[1], coord[0]);
                                      widget.fromAddrData.inputText =
                                          snapshot.data.inputText;
                                      widget.fromAddrData.isSet = true;
                                    });
                                  }
                                  if (widget.toAddrData.isSet &&
                                      widget.fromAddrData.isSet) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ConfirmationScreen(
                                              toAddrData: widget.toAddrData,
                                              fromAddrData:
                                                  widget.fromAddrData);
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  color: index % 2 == 0
                                      ? Colors.transparent
                                      : Colors.grey[50].withOpacity(0.05),
                                  child: Text(
                                    placeDataSnapshot.data.name[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Text(
                          "Searching",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  },
                ),
              );
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
