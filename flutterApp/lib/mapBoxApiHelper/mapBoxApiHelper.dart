import 'dart:convert' as convert;
import 'package:http/http.dart';

// Future<void> main() async {
//   String origin = '79.9188,27.05524';
//   String destination = '80.915661,26.8660711';
//   String accessToken =
//       'pk.eyJ1IjoibXJhZ25pIiwiYSI6ImNrajVqZ3JsYjFvdWwyeWxnaDA3czZmb28ifQ.E1bMpW9uDw1nhMgiNz-lDA';
//   getRouteCoords(origin, destination, accessToken);
//   getMatchingLocations("kann", destination, accessToken);

// }

getRouteCoords(origin, destination, accessToken) async {
  String url =
      "https://api.mapbox.com/directions/v5/mapbox/driving/$origin;$destination?overview=full&geometries=geojson&access_token=$accessToken";
  print(url);
  var response = await get(url);
  var jsonResponse = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {
    var len = jsonResponse['routes'][0]['geometry']['coordinates'].length;
    var coords = jsonResponse['routes'][0]['geometry']['coordinates'];
    // for (var i = 0; i < len; i++) {
    //   print(jsonResponse['routes'][0]['geometry']['coordinates'][i]);
    // }
  } else {
    print(jsonResponse['message']);
  }
}

getMatchingLocations(location, searchNear, accessToken) async {
  var url =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?country=IN&proximity=$searchNear&access_token=$accessToken';
  var response = await get(url);
  var jsonResponse = convert.jsonDecode(response.body);
  print("\n\n\n");
  if (response.statusCode == 200) {
    print(jsonResponse);
    for (var i = 0; i < jsonResponse['features'].length; i++) {
      print(jsonResponse['features'][i]['place_name']);
    }
  } else {
    print(jsonResponse['message']);
  }
}
