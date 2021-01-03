import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:testing/Screens/map/apiKey.dart';


getRouteCoords(origin, destination) async {
  String url =
      "https://api.mapbox.com/directions/v5/mapbox/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson&access_token=$accessToken";
  var list = await get(url).then((value) {
    var jsonResponse = convert.jsonDecode(value.body);
    if (value.statusCode == 200) {
      var len = jsonResponse['routes'][0]['geometry']['coordinates'].length;
      var coords = jsonResponse['routes'][0]['geometry']['coordinates'];
      var latlngCoords = <LatLng>[];
      for (var i = 0; i < len; i++) {
        latlngCoords.add(new LatLng(coords[i][1], coords[i][0]));
      }
      return latlngCoords;
    } else {
      print(jsonResponse['message']);
      return <LatLng>[];
    }
  });
  return list;
}

class placeList {
  var name = [];
  var latlng = [];
}

getMatchingLocations(location, streamController) async {
  var geoLocation = await Location().getLocation();
  var url =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?country=IN&proximity=${geoLocation.longitude},${geoLocation.latitude}&access_token=$accessToken';
  print(url);
  var response = await get(url);
  var data = placeList();
  var jsonResponse = convert.jsonDecode(response.body);
  for (var i = 0; i < jsonResponse['features'].length; i++) {
    data.name.add(jsonResponse['features'][i]['place_name']);
    data.latlng.add(jsonResponse['features'][i]['geometry']['coordinates']);
  }
  streamController.add(data);
}
