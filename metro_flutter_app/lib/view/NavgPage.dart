import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/view/HomePage.dart';
import 'package:metro_flutter_app/view/Settings.dart';
import 'package:metro_flutter_app/view/SubscriptionPage.dart';
import '../component/main_drawer.dart';

class navScreen extends StatefulWidget {
  @override
  _navScreenState createState() => _navScreenState();
}

class _navScreenState extends State<navScreen> {
  List<Widget> screens = [
    homepage(),
    subscription(),
    settings(),
  ];
  Map<String, IconData> icons = {
    "Home": Icons.home,
    "Subscription": Icons.subscriptions,
    "Settings": Icons.settings,
  };
  int currentindex = 0;
  String currentpage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: screens[currentindex],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30.0,
                  ),
                  title: Text(title),
                )))
            .values
            .toList(),
        currentIndex: currentindex,
        selectedFontSize: 11.0,
        selectedItemColor: Color(0xffa80f14),
        unselectedItemColor: Colors.black,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() {
          currentindex = index;
        }),
      ),
    );
  }
}
