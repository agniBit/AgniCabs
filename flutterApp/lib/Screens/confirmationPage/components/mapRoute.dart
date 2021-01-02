import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:testing/Screens/map/apiKey.dart';
import 'package:testing/Screens/map/mapBoxApiHelper/mapBoxApiHelper.dart';

class MapRoute extends StatefulWidget {
  const MapRoute({
    Key key,
    @required this.start,
    @required this.end,
  }) : super(key: key);

  final LatLng start;
  final LatLng end;

  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  @override
  Widget build(BuildContext context) {
    LatLngBounds bounds = new LatLngBounds();
    bounds.extend(widget.start);
    bounds.extend(widget.end);
    return FutureBuilder(
      future: getRouteCoords(widget.start, widget.end),
      builder: (context, AsyncSnapshot routeCoords) {
        if (routeCoords.hasData) {
          return Container(
            child: FlutterMap(
              options: MapOptions(
                  bounds: bounds,
                  boundsOptions: FitBoundsOptions(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0)),
                  maxZoom: 16.0,
                  minZoom: 3.0),
              layers: [
                TileLayerOptions(urlTemplate: urlTemplate, additionalOptions: {
                  'accessToken': accessToken,
                  'id': 'mapbox.mapbox-streets-v8'
                }),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 0.0,
                      height: 40.0,
                      point: widget.start,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: widget.end,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
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
          );
        } else {
          return Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
