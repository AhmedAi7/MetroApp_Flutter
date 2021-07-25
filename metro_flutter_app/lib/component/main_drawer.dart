import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget buildListTile(String title, IconData icon, Function location) {
    return ListTile(
        leading: Icon(
          icon,
          size: 24,
          color: Color(0xffa80f14),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xffa80f14),
          ),
        ),
        onTap: location);
  }

  String _username= " ";

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username");
    });
  }

  @override
  void initState() {
    super.initState();
    _username = "";
    getSharedPrefs();
  }

  Widget buildIcon(
      String title, String iconName, double size, Function location) {
    String name = "images/" + iconName;
    return ListTile(
        leading: ImageIcon(
          AssetImage(name),
          color: Color(0xffa80f14),
          size: size,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xffa80f14),
          ),
        ),
        onTap: location);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            color: Color(0xffa80f14),
            // #A80F14 red
            child: Row(
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                  size: 35,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  _username,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Color(0xFFFFFFFF)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Home',
            Icons.home,
            () {
              Navigator.popAndPushNamed(context, 'HomePage');
            },
          ),
          buildIcon(
            'My Tickets',
            'ticket.png',
            25,
            () {
              Navigator.pushNamed(context, 'MyTickets');
            },
          ),
          buildIcon(
            'Nearset Station',
            'walk.png',
            45,
            () {
              Navigator.pushNamed(context, 'NearestStation');
            },
          ),
          buildIcon(
            'Get Route',
            'route.png',
            20,
            () {
              Navigator.pushNamed(context, 'GetRoute');
            },
          ),
          buildListTile(
            'Subscription',
            Icons.subscriptions_rounded,
            () {
              Navigator.pushNamed(context, 'Subscription');
            },
          ),
          buildListTile(
            'Metro Map',
            Icons.map,
            () {
              Navigator.pushNamed(context, 'MetroMap');
            },
          ),
          buildListTile(
            'Contact Us',
            Icons.support_agent_rounded,
            () {
              Navigator.pushNamed(context, 'ContactUs');
            },
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () {
              Navigator.pushNamed(context, 'Settings');
            },
          ),
          buildListTile(
            'Log Out',
            Icons.logout,
            () async {
              SharedPreferences sh = await SharedPreferences.getInstance();
              await sh.clear();
              Navigator.pushNamed(context, 'LogOut');
            },
          ),
        ],
      ),
    );
  }
}
