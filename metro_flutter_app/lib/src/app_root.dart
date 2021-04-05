import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/view/HomePage.dart';
import 'package:metro_flutter_app/view/LoginPage.dart';
import 'package:metro_flutter_app/view/NavgPage.dart';
import 'package:metro_flutter_app/view/Settings.dart';
import 'package:metro_flutter_app/view/SignUp1Page.dart';
import 'package:metro_flutter_app/view/SignUp2Page.dart';
import 'package:metro_flutter_app/view/SubscriptionPage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro App',
      initialRoute: 'Login',
      routes: {
        'Login': (context) => LoginPage(),
        'SignUp1': (context) => SignUp1Page(),
        'SignUp2': (context) => SignUp2Page(),
        'HomePage': (context) => homepage(),
        'Subscription': (context) => subscription(),
        'Settings': (context) => settings(),
        "NavgPage": (context) => navScreen(),
        //"MyTickets":(context)=>MyTickets(),
        //'SignUp3' :(context) => SignUp3Page(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
