import 'package:flutter/material.dart';
import 'package:testing/Screens/map/mapBoxApiHelper/mapBoxApiHelper.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:testing/Screens/map/apiKey.dart';

class DisplayMapWithRoute extends StatefulWidget {
  const DisplayMapWithRoute({
    Key key,
    @required this.origin,
    @required this.destination,
  }) : super(key: key);

  final String origin;
  final String destination;

  @override
  _DisplayMapWithRouteState createState() => _DisplayMapWithRouteState();
}

class _DisplayMapWithRouteState extends State<DisplayMapWithRoute> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getRouteCoords(widget.origin, widget.destination),
      builder: (context, AsyncSnapshot routeCoords) {
        if (routeCoords.hasData) {
          return (Container(
            child: FlutterMap(
              options: MapOptions(center: routeCoords.data[0], maxZoom: 14.0),
              layers: [
                TileLayerOptions(urlTemplate: urlTemplate, additionalOptions: {
                  'accessToken': accessToken,
                  'id': 'mapbox.mapbox-streets-v8'
                }),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: routeCoords.data[0],
                      builder: (context) => Container(
                        child:IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.deepOrange[700],
                          iconSize: 40.0,
                          onPressed: () {
                            print("Marker Tapped");
                          },
                        ),
                      ),
                    ),
                    Marker(
                      width: 150,
                      height: 80,
                      point: routeCoords.data[0],
                      builder: (context) => Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 40),
                        child:Text(
                          "Current Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new PolylineLayerOptions(polylines: [
                  Polyline(
                      points: routeCoords.data,
                      strokeWidth: 6.0,
                      color: Colors.deepPurple),
                ])
              ],
            ),
          ));
        } else {
          return Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
