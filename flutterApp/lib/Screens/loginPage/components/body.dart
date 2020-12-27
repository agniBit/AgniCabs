import 'package:flutter/material.dart';
import 'package:testing/Screens/loginPage/components/textinputfield.dart';
import 'package:testing/Screens/map/mapSearchScreen.dart';
import 'package:testing/const.dart';
import 'package:testing/serverAPIs/authUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email;
    String password;
    return Container(
      alignment: Alignment.center,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'signin',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          SizedBox(
            height: size.height * .07,
          ),
          Textinputfiel(
            child: TextField(
              onChanged: (newText) {
                email = newText;
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: primarycolor,
                ),
                hintText: "Email",
                border: InputBorder.none,
              ),
            ),
          ),
          // SizedBox(height: size.height*.05,),
          Textinputfiel(
            child: TextField(
              obscureText: true,
              onChanged: (newText) {
                password = newText;
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: primarycolor,
                ),
                suffixIcon: Icon(Icons.visibility),
                hintText: "Password",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: primarycolor,
                  onPressed: () {
                    login(email, password).then((val) {
                      try {
                        if (val.data['success']) {
                          // var token = val.data['token'];
                          Fluttertoast.showToast(
                              msg: 'authentication successful',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MapSearchScreen();
                          }));
                        }
                      } catch (e) {
                        print("response error");
                      }
                    });
                  },
                  child: Text(
                    'Signin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
