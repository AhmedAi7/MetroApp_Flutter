import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/models/NormalSubscription.dart';
import 'package:metro_flutter_app/view/Update_Subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NormalSubscription3 extends StatefulWidget {
  @override
  _NormalSubscription3State createState() => _NormalSubscription3State();
}

class _NormalSubscription3State extends State<NormalSubscription3> {
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
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      print("Response :" + jsonResponse["source"]);
      setState(() {
        source = jsonResponse["source"];
        target = jsonResponse["target"];
        Start_date = jsonResponse["Start_date"];
        End_date = jsonResponse["End_date"];
        trips_num = jsonResponse["trips_num"];
        Start_date = Start_date.split(" ")[0];
        End_date = End_date.split(" ")[0];
      });
      setState(() {
        print("NO " + jsonResponse["source"]);
      });
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  String source = "";
  String target = "";
  String Start_date = "";
  String End_date = "";
  String trips_num = "";
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    if (counter == 0) {
      setState(() {
        checkSubscripe();
        counter++;
      });
    }
    return Scaffold(
        body: Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.dstIn,
            ),
          ),
        ),
      ),
      arrowback(context),
      Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Expanded(
              //child:
              Container(
                alignment: Alignment.bottomCenter,
                height: 300,
                width: 400,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Available Trips : $trips_num ",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    Text(
                      "Source : $source",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    Text(
                      "Destination : $target",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    Text(
                      "Start Date : $Start_date",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    Text(
                      "End Date : $End_date",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                    Text(
                      "___________",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 0.0, top: 0.0, right: 0, bottom: 10.0),
                height: 50,
                width: 400,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  //padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                  color: const Color(0xffa80f14),
                  child: Text(
                    "Use Subscription",
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Segoe UI',
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.0),
      Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateSubscription(),
                ));
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Container(
              width: 200,
              height: 50,
              decoration:
                  CustomBoxDecoration.decorationStyle(Color(0xFFFFFFFF), 10.0),
              child: Center(
                child: Text(
                  "Renew Subscription",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}
