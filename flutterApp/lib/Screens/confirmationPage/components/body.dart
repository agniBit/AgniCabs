import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testing/Screens/confirmationPage/components/mapRoute.dart';
import 'package:latlong/latlong.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng end = LatLng(26.449923, 80.331871);
    LatLng start = LatLng(26.850000, 80.949997);
    var mQ = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          SizedBox(
            width: 10,
          ),
          Icon(Icons.arrow_back),
          SizedBox(
            width: 30,
          ),
          Text('AgniCabs'),
        ]),
      ),
      body: Container(
        height: mQ.height,
        width: mQ.width,
        child: Column(children: [
          Expanded(
            flex: 6,
            child: MapRoute(
              start: start,
              end: end,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Distance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '8.85 Km',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Estimated Cost',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '110 Rs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(15),
              width: mQ.width * .85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.deepPurple,
                  shadowColor: Colors.deepPurple,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  print('confirm');
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
