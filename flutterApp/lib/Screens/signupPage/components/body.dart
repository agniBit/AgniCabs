import 'package:flutter/material.dart';
import 'package:login_app/Screens/signupPage/components/inputTextFiels.dart';
import 'package:login_app/const.dart';
import 'package:login_app/serverAPIs/addNewUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    InputTextField name, username, email, password;
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Register User",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          name = InputTextField(
            size: size,
            hintText: 'Name',
            icon: Icon(
              Icons.person,
              color: primarycolor,
            ),
          ),
          email = InputTextField(
            size: size,
            hintText: 'Email',
            icon: Icon(
              Icons.email,
              color: primarycolor,
            ),
          ),
          username = InputTextField(
            size: size,
            hintText: 'Username',
            icon: Icon(
              Icons.person,
              color: primarycolor,
            ),
          ),
          password = InputTextField(
            size: size,
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: primarycolor,
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
                    AddNewUser(name.inputText, email.inputText,
                            password.inputText, username.inputText)
                        .then((val) {
                      if (val.data['success']) {
                        Fluttertoast.showToast(
                            msg: 'authentication successful',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16);
                      }
                    });
                  },
                  child: Text(
                    'Regsiter',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
