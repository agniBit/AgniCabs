import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';

// Future<void> main() async {
//   String origin = '79.9188,27.05524';
//   String destination = '80.915661,26.8660711';
//   getRouteCoords(origin, destination, accessToken);
//   getMatchingLocations("kann", destination, accessToken);

// }

getRouteCoords(origin, destination, accessToken) async {
  String url =
      "https://api.mapbox.com/directions/v5/mapbox/driving/$origin;$destination?overview=full&geometries=geojson&access_token=$accessToken";
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

getMatchingLocations(location, searchNear, accessToken) async {
  var url =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?country=IN&proximity=$searchNear&access_token=$accessToken';
  var response = await get(url);
  var jsonResponse = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(jsonResponse);
    for (var i = 0; i < jsonResponse['features'].length; i++) {
      print(jsonResponse['features'][i]['place_name']);
    }
  } else {
    print(jsonResponse['message']);
  }
}
