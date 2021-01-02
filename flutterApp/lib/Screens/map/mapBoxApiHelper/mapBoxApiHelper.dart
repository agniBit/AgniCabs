import 'dart:convert' as convert;
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:testing/Screens/map/apiKey.dart';

// Future<void> main() async {
//   String origin = '79.9188,27.05524';
//   String destination = '80.915661,26.8660711';
//   getRouteCoords(origin, destination, accessToken);
//   getMatchingLocations("kann", destination, accessToken);

// }

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
  // var response = await get(url);
  var data = placeList();
  var jsonResponse = convert.jsonDecode(
      '{"type":"FeatureCollection","query":["ka"],"features":[{"id":"district.3781598674410210","type":"Feature","place_type":["district"],"relevance":1,"properties":{"wikidata":"Q627979"},"text":"Kannauj","place_name":"Kannauj, Uttar Pradesh, India","bbox":[79.315952,26.769566,80.021863,27.229108],"center":[79.92,27.07],"geometry":{"type":"Point","coordinates":[79.92,27.07]},"context":[{"id":"region.11049584031190310","wikidata":"Q1498","short_code":"IN-UP","text":"Uttar Pradesh"},{"id":"country.2782945337","wikidata":"Q668","short_code":"in","text":"India"}]},{"id":"locality.3224308459557550","type":"Feature","place_type":["locality"],"relevance":1,"properties":{},"text":"Kandrauli Bangar","place_name":"Kandrauli Bangar, Kannauj, Kannauj, Uttar Pradesh, India","bbox":[79.8933858419174,27.0552720561753,79.9210975216021,27.0749044846707],"center":[79.907357,27.06495],"geometry":{"type":"Point","coordinates":[79.907357,27.06495]},"context":[{"id":"place.3732925368410210","wikidata":"Q614890","text":"Kannauj"},{"id":"district.3781598674410210","wikidata":"Q627979","text":"Kannauj"},{"id":"region.11049584031190310","wikidata":"Q1498","short_code":"IN-UP","text":"Uttar Pradesh"},{"id":"country.2782945337","wikidata":"Q668","short_code":"in","text":"India"}]},{"id":"locality.4821498267474670","type":"Feature","place_type":["locality"],"relevance":1,"properties":{},"text":"Kannauj Kachhoha","place_name":"Kannauj Kachhoha, Kannauj, Kannauj, Uttar Pradesh, India","bbox":[79.9288015777936,27.0475263803094,79.9462207053797,27.0641069855684],"center":[79.934687,27.055706],"geometry":{"type":"Point","coordinates":[79.934687,27.055706]},"context":[{"id":"place.3732925368410210","wikidata":"Q614890","text":"Kannauj"},{"id":"district.3781598674410210","wikidata":"Q627979","text":"Kannauj"},{"id":"region.11049584031190310","wikidata":"Q1498","short_code":"IN-UP","text":"Uttar Pradesh"},{"id":"country.2782945337","wikidata":"Q668","short_code":"in","text":"India"}]},{"id":"locality.8599023978840290","type":"Feature","place_type":["locality"],"relevance":1,"properties":{},"text":"Karanpur","place_name":"Karanpur, Kannauj, Kannauj, Uttar Pradesh, India","bbox":[79.8751059017672,27.0319606752951,79.888894079706,27.040242129527],"center":[79.880986,27.036044],"geometry":{"type":"Point","coordinates":[79.880986,27.036044]},"context":[{"id":"place.3732925368410210","wikidata":"Q614890","text":"Kannauj"},{"id":"district.3781598674410210","wikidata":"Q627979","text":"Kannauj"},{"id":"region.11049584031190310","wikidata":"Q1498","short_code":"IN-UP","text":"Uttar Pradesh"},{"id":"country.2782945337","wikidata":"Q668","short_code":"in","text":"India"}]},{"id":"locality.9487179599491930","type":"Feature","place_type":["locality"],"relevance":1,"properties":{},"text":"Katri Kasimpur","place_name":"Katri Kasimpur, Kannauj, Kannauj, Uttar Pradesh, India","bbox":[79.9733113790438,27.0333109228616,79.9915017391363,27.0469288720288],"center":[79.980678,27.039451],"geometry":{"type":"Point","coordinates":[79.980678,27.039451]},"context":[{"id":"place.3732925368410210","wikidata":"Q614890","text":"Kannauj"},{"id":"district.3781598674410210","wikidata":"Q627979","text":"Kannauj"},{"id":"region.11049584031190310","wikidata":"Q1498","short_code":"IN-UP","text":"Uttar Pradesh"},{"id":"country.2782945337","wikidata":"Q668","short_code":"in","text":"India"}]}],"attribution":"NOTICE: © 2020 Mapbox and its suppliers. All rights reserved. Use of this data is subject to the Mapbox Terms of Service (https://www.mapbox.com/about/maps/). This response and the information it contains may not be retained. POI(s) provided by Foursquare."}');
  for (var i = 0; i < jsonResponse['features'].length; i++) {
    data.name.add(jsonResponse['features'][i]['place_name']);
    data.latlng.add(jsonResponse['features'][i]['geometry']['coordinates']);
  }
  streamController.add(data);
}
