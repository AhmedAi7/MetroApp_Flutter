import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/view/LoginPage.dart';
import 'package:metro_flutter_app/view/SignUp1Page.dart';
import 'package:metro_flutter_app/view/SignUp2Page.dart';

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
        //'SignUp3' :(context) => SignUp3Page(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
