import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon) {
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
      onTap: () {
        // ...
      },
    );
  }

  Widget buildIcon(String title, String iconName, double size) {
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
      onTap: () {
        // Navigator.pushNamed(context, 'Home');
      },
    );
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
            alignment: Alignment.centerLeft,
            color: Color(0xffa80f14),
            // #A80F14 red
            child: Text(
              'User123',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildIcon(
            'My Tickets',
            'ticket.png',
            25,
          ),
          buildIcon(
            'Nearset Staion',
            'walk.png',
            45,
          ),
          buildIcon(
            'Get Route',
            'route.png',
            20,
          ),
          buildListTile(
            'Subscription',
            Icons.subscriptions_rounded,
          ),
          buildListTile(
            'Contact Us',
            Icons.support_agent_rounded,
          ),
          buildListTile(
            'Settings',
            Icons.settings,
          ),
          buildListTile(
            'Log Out',
            Icons.logout,
          ),
        ],
      ),
    );
  }
}
