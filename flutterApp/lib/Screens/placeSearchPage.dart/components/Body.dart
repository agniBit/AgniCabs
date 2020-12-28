import 'package:flutter/material.dart';
import 'package:testing/Screens/map/components/searchBox.dart';
import 'package:testing/Screens/placeSearchPage.dart/components/displayAddrSuggestions.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          SearchBox(size: size, hintText: 'Search'),
          DisplayAddrSuggetions(),
          ],
      ),
    );
  }
}
