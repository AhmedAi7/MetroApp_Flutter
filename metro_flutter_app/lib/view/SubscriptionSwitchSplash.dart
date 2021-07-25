import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/NormalSubscription.dart';
import 'package:metro_flutter_app/view/NormalSubscripPage1.dart';
import 'package:metro_flutter_app/view/NormalSubscripPage3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'HomeSplash.dart';

class SubscriptionSwitchSplash extends StatefulWidget {
  @override
  _SubscriptionSwitchSplashState createState() =>
      _SubscriptionSwitchSplashState();
}

class _SubscriptionSwitchSplashState extends State<SubscriptionSwitchSplash> {
  Future<bool> checkSubscripe() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    var Url = "http://localhost:8080/CheckSubscripe";
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });
    setState(() {
      res = response;
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      return true;
    } else {
      setState(() {
        print(response.statusCode);
      });
      return null;
    }
  }

  List<Widget> screens = [NormalSubscription1(), NormalSubscription3()];
  var subscripe;

  @override
  void initState() {
    subscripe = checkSubscripe();
    super.initState();
  }

  Widget selectedscreen;
  int counter = 0;
  http.Response res;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: subscripe, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (res.statusCode == 200) {
              selectedscreen = screens[1];
            } else {
              selectedscreen = screens[0];
            }
            return selectedscreen;
          }
        });
  }
}
