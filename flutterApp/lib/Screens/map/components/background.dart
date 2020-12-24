import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_app/Screens/map/apiKey.dart';

class background extends StatefulWidget {
  final Widget child;
  background({Key key, this.child}) : super(key: key);
  @override
  _backgroundState createState() => _backgroundState(this.child);
}

class _backgroundState extends State<background> {
  final Set<Polyline> polyline = {};
  GoogleMapController _controller;
  List<LatLng> routeCords;
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: apiKey);
  final Widget _child;
  _backgroundState(this._child);
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(children: [
        Positioned(
          child: GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 17),
            mapType: MapType.normal,
          ),
        ),
        _child,
    ]));
  }
}
