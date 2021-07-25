import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/view/HomePage.dart';
import 'package:metro_flutter_app/view/HomeSplash.dart';
import 'package:metro_flutter_app/view/NormalSubscripPage1.dart';
import 'package:metro_flutter_app/view/Settings.dart';
import 'package:metro_flutter_app/view/SettingsSplash.dart';
import 'package:metro_flutter_app/view/SubscriptionPage.dart';
import 'package:metro_flutter_app/view/SubscriptionSwitchSplash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/main_drawer.dart';
import 'HomePageSplash.dart';
import 'SubscriptionSwitch.dart';

class NavScreen extends StatefulWidget {
  final index1;
  const NavScreen(this.index1);

  @override
  _NavScreenState createState() => _NavScreenState(index1);
}

class _NavScreenState extends State<NavScreen> {

  _NavScreenState(index1) {
    currentindex = index1;
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
  List<Widget> screens = [
    HomePageSplash(),
    SubscriptionSwitchSplash(),
    SettingsSplash(),
  ];
  Map<String, IconData> icons = {
    "Home": Icons.home,
    "Subscription": Icons.subscriptions,
    "Settings": Icons.settings,
  };
  int currentindex;
  String currentpage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(_username),
      body: screens[currentindex],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: icons
            .map(
              (title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30.0,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(title),
                ),
              ),
            )
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
