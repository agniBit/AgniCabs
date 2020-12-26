import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';

class Background extends StatefulWidget {
  final Widget child;
  @override
  Background({Key key, this.child}) : super(key: key);
  _BackgroundState createState() => _BackgroundState(child);
}

class _BackgroundState extends State<Background> {
  final Set<Polyline> polyline = {};
  final Widget child;
  GoogleMapController _controller;
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: apiKey);

  _BackgroundState(this.child);

  getsomePoints() async {
    var permissions =
        await Permission.getPermissionsStatus([PermissionName.Location]);
    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
      print("ask permission");
      var askpermissions =
          await Permission.requestPermissions([PermissionName.Location]);
    } else {
      // routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
      //     origin: LatLng(40.6782, -73.9442),
      //     destination: LatLng(40.6944, -73.9212),
      //     mode: Ro);
      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(40.6782, -73.9442),
          destination: LatLng(40.677939, -73.941755),
          mode: RouteMode.walking);
      print("else statement $routeCoords");
    }
  }

  // getaddressPoints() async {
  //   routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
  //       origin: 'Brooklyn',
  //       destination: '178 Broadway, Brooklyn',
  //       mode: RouteMode.driving);
  // }

  @override
  void initState() {
    super.initState();
    getsomePoints();
  }

  @override
  Widget build(BuildContext context) {
    getsomePoints();
    return Stack(children: [
      GoogleMap(
        onMapCreated: onMapCreated,
        polylines: polyline,
        initialCameraPosition:
            CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 14.0),
        mapType: MapType.normal,
      ),
      child,
    ]);
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      print("\n\non create map:- $routeCoords \n\n");
      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }
}
