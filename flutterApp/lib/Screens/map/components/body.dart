import 'package:flutter/material.dart';
import 'package:login_app/const.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String inputText;
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: size.width*.8,
            margin:
                EdgeInsets.symmetric(vertical: 2, horizontal: size.width * .04),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: primarycolorlight,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (text) {
                inputText = text;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "from ",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: size.width*.8,
            margin:
                EdgeInsets.symmetric(vertical: 2, horizontal: size.width * .04),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: primarycolorlight,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (text) {
                inputText = text;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "from ",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
      Container(
        width: size.width*.1,
        height: 40,
        child: Image.asset("assets/transparent-wedding-icon-bouquet-icon-5fc31666599653.040194881606620774367.png")
      ),
      ]
    );
  }
}
