import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _username=" ";
Future<Null> getSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _username = prefs.getString("username");
}

@override
void initState() {
  initState();
  _username = "";
  getSharedPrefs();
}

AppBar buildAppBar(String Title) {
  return AppBar(
    backgroundColor: const Color(0xffa80f14),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          Title??"",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        )
      ],
    ),
  );
}
