import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/view/Buy%20Tickets.dart';
import 'package:metro_flutter_app/view/ChargeWallet.dart';
import 'package:metro_flutter_app/view/MyTicketss.dart';
import 'package:metro_flutter_app/view/UseTicket.dart';
import 'package:metro_flutter_app/view/confirm_password.dart';
import 'package:metro_flutter_app/view/edit_email.dart';
import 'package:metro_flutter_app/view/edit_phoneNumber.dart';
import 'package:metro_flutter_app/view/nearest_station.dart';
import 'package:metro_flutter_app/view/LoginPage.dart';
import 'package:metro_flutter_app/view/NavgPage.dart';
import 'package:metro_flutter_app/view/SignUp1Page.dart';
import 'package:metro_flutter_app/view/SignUp2Page.dart';
import 'package:metro_flutter_app/view/contact_us.dart';
import 'package:metro_flutter_app/view/get_route.dart';
import 'package:metro_flutter_app/view/reset_password.dart';
import 'package:metro_flutter_app/view/SignUp3Page.dart';
import 'package:metro_flutter_app/view/SignUp4Page.dart';

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
        'ResetPassword': (context) => ResetPassword(),
        "MyTickets": (context) => mytickets(),
        'GetRoute': (context) => GetRoute(),
        'ContactUs': (context) => ContactUs(),
        "UseTickets": (context) => useticket(),
        'SignUp3': (context) => SignUp3Page(),
        'SignUp4': (context) => SignUp4Page(),
        'EditPhoneNumber': (context) => EditPhoneNumber(),
        'EditEmail': (context) => EditEmail(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
