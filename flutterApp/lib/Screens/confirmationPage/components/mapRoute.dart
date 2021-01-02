import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:testing/Screens/map/apiKey.dart';

class MapRoute extends StatefulWidget {
  const MapRoute({Key key, @required this.start, @required this.end})
      : super(key: key);

  final LatLng start;
  final LatLng end;

  @override
  MapRouteState createState() {
    return MapRouteState();
  }
}

class MapRouteState extends State<MapRoute> with TickerProviderStateMixin {
  MapController mapController;
  var bounds;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {

    LatLngBounds bounds = new LatLngBounds();
    bounds.extend(widget.start);
    bounds.extend(widget.end);

    return Container(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          bounds:  bounds,
          boundsOptions: FitBoundsOptions(padding: EdgeInsets.only(left: 20.0,right: 20.0)),
          maxZoom: 16.0,
          minZoom: 3.0
        ),
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
        ],
      ),
    );
  }
}
