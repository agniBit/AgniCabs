import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:testing/Screens/map/components/addrSuggestionsWidget.dart';
import 'package:testing/Screens/map/components/searchBox.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:testing/Screens/map/apiKey.dart';

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
  LocationData _currentLocation;
  MapController _mapController;

  // ignore: close_sinks
  StreamController addrStreamController;
  Stream addrStream;

  bool _liveUpdate = true;
  bool _permission = false;

  String _serviceError = '';

  final Location _locationService = Location();

  @override
  initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
    addrStreamController = new StreamController.broadcast();
    addrStream = addrStreamController.stream;
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.HIGH,
      interval: 1000,
    );

    LocationData location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.GRANTED;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation.latitude,
                          _currentLocation.longitude),
                      _mapController.zoom);
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  set closeOtherAddrSuggestionsWidget(bool value) {
    this.openFromSuggestionWidget = value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: close_sinks

    LatLng currentLatLng;
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation.latitude, _currentLocation.longitude);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    var markers = <Marker>[
      Marker(
        width: 60.0,
        height: 60.0,
        point: currentLatLng,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.deepOrange,
            size: 60,
          ),
        ),
      ),
    ];
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(currentLatLng.latitude, currentLatLng.longitude),
                zoom: 17.0,
              ),
              layers: [
                TileLayerOptions(urlTemplate: urlTemplate, additionalOptions: {
                  'accessToken': accessToken,
                  'id': 'mapbox.mapbox-streets-v8'
                }),
                MarkerLayerOptions(markers: markers)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => _liveUpdate = !_liveUpdate,
            child: _liveUpdate
                ? Icon(Icons.location_on)
                : Icon(Icons.location_off),
          ),
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
        Positioned(
          top: 130,
          child: AddrSuggestionsWidget(
            stream: addrStream,
            size: size,
          ),
        ),
      ],
    );
  }
}
