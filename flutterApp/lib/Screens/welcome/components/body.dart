import 'package:flutter/material.dart';
import 'package:login_app/Screens/loginPage/login.dart';
import 'package:login_app/Screens/signupPage/siginupScreen.dart';
import 'package:login_app/const.dart';
import 'package:login_app/Screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      size: size,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .15,
          ),
          Text('Welcome to Login MrAgni',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          SizedBox(
            height: size.height * .05,
          ),
          Image.asset(
            "assets/kisspng-wedding-invitation-vector-graphics-portable-networ-5cf0a2b136e7a9.8610740215592741612249.png",
            height: size.height * 0.45,
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
      ),
    );
  }
}
