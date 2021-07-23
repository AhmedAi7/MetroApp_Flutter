import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/User_Status.dart';
import 'package:metro_flutter_app/view/HomePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//
// import 'NavgPage.dart';
//
// class HomeSplash extends StatefulWidget {
//   @override
//   _HomeSplashState createState() => _HomeSplashState();
// }
//
// class _HomeSplashState extends State<HomeSplash> {
//   @override
//   Widget build(BuildContext context) {
//    // AnimatedSplashScreen(splash: splash, nextScreen: nextScreen)
//     return AnimatedSplashScreen.withScreenFunction(
//       splash: 'images/metro-logo.png',
//       screenFunction: () async{
//         SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
//         String token="Bearer "+sharedPreferences.getString("token");
//         setState(() {
//           print(token);
//         });
//
//         var jsonResponse;
//         var Url="https://metro-ticket-reservation-app.herokuapp.com/GetUser";
//         var response =await http.get(Uri.parse(Url),
//             headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});
//         var balance;
//         if(response.statusCode==200) {
//           jsonResponse = json.decode(response.body);
//           print("ResponseBody : "+response.body);
//           print("Response :"+jsonResponse["balance"]);
//           setState(() {
//             loginStatues().setUser(jsonResponse["fullname"], jsonResponse["email"], jsonResponse["password"], jsonResponse["phone_number"], jsonResponse["date_of_birth"],jsonResponse["balance"]);
//           });
//         }
//         else
//         {
//           setState(() {
//             print(response.statusCode);
//           });
//         }
//         return HomePage();
//       },
//       splashTransition: SplashTransition.rotationTransition,
//       pageTransitionType: PageTransitionType.scale,
//     );
//
//   }
// }
//
class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

class Splash extends State<SplashScreen>  {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // Timer(
    //     Duration(seconds: 3),
    //         () =>
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //             builder: (BuildContext context) => LandingScreen())));


    var assetsImage = new AssetImage(
        'images/metro-logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height:300); //<- Creates a widget that displays an image.

    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor:
              Colors.blue, //<- background color to combine with the picture :-)
        ),*/
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: image,
          ),
        ), //<- place where the image appears
      ),
    );
  }
}
