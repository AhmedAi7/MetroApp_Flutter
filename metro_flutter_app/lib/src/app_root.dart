import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/view/Buy%20Tickets.dart';
import 'package:metro_flutter_app/view/ChargeWallet.dart';
import 'package:metro_flutter_app/view/MyTicketss.dart';
import 'package:metro_flutter_app/view/nearest_station.dart';
import 'package:metro_flutter_app/view/LoginPage.dart';
import 'package:metro_flutter_app/view/NavgPage.dart';
import 'package:metro_flutter_app/view/SignUp1Page.dart';
import 'package:metro_flutter_app/view/SignUp2Page.dart';
//import 'package:metro_flutter_app/view/reset_password.dart';
//import 'package:metro_flutter_app/view/update_info.dart';
import 'package:metro_flutter_app/view/Buy%20Tickets.dart';

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
        'HomePage': (context) => navScreen(0),
        'Subscription': (context) => navScreen(1),
        'Settings': (context) => navScreen(2),
        'NavgPage': (context) => navScreen(0),
        'Recharge': (context) => chargewallet(),
        'BuyTickets': (context) => buyticket(),
        'NearestStation': (context) => NearestStation(),
        //'ResetPassword': (context) => ResetPassword(),
        "MyTickets": (context) => mytickets(),
        //'GetRoute': (context) => GetRoute();
        //'ContactUs': (context) => ContactUs();
        //'LogOut': (context) => LogOut();
        //"MyTickets":(context)=> MyTickets(),
        //'SignUp3' :(context) => SignUp3Page(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
