import 'package:flutter/material.dart';
import 'package:testing/Screens/loginPage/login.dart';
import 'package:testing/Screens/signupPage/siginupScreen.dart';
import 'package:testing/const.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome to Login MrAgni',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        SizedBox(
          height: size.height * .05,
        ),
        Container(
          width: size.width,
          alignment: Alignment.center,
          child: Image.asset(
            "assets/logo.png",
            height: size.height * 0.25,
          ),
        ),
        SizedBox(
          height: size.height * .04,
        ),
        Container(
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: primarycolor,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Loginscreen();
                    },
                  ));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Container(
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: primarycolorlight,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
                    },
                  ));
                },
                child: Text(
                  'Signup',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: primarycolor),
                )),
          ),
        )
      ],
    );
  }
}
