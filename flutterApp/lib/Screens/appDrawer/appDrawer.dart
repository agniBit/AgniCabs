import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              // height: mQ.height * .25,
              color: Colors.deepPurple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mQ.height * .04,
                  ),
                  Container(
                    height: mQ.height * .12,
                    width: mQ.height * .12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                          image: AssetImage('assets/profile.jpeg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: mQ.height * .02,
                  ),
                  Text(
                    'Abhishek Agnihotri',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mQ.height * .01),
                  Text(
                    '782091924',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mQ.height * .01),
                ],
              ),
            ),
            AppDrawerTile(
              name: 'Home',
              icon: Icon(Icons.home),
            ),
            AppDrawerTile(
              name: 'History',
              icon: Icon(Icons.history),
            ),
            AppDrawerTile(
              name: 'Settings',
              icon: Icon(
                Icons.settings,
              ),
            ),
            AppDrawerTile(
              name: 'Help',
              icon: Icon(Icons.help),
            ),
            AppDrawerTile(
              name: 'LogOut',
              icon: Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({Key key, this.name, this.icon}) : super(key: key);
  final String name;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          icon,
          SizedBox(
            width: 30,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
