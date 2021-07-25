import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/TicketsTypes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeSplash.dart';
import 'NavgPage.dart';

class BuyTicket extends StatefulWidget {
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  Future<bool> alertDialog(String text, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Done'),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  List<dynamic> Tickets;

  Future<bool> GetBasicTickets() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    var Url = "http://localhost:8080/GetBasicTickets";
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });

    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      print("Response" + jsonResponse["Basic Tickets:"].toString());
      setState(() {
        Tickets = jsonResponse["Basic Tickets:"];
        _Set_Tickets();
        print("Tickets" + Tickets.toString());
      });
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  void _Set_Tickets() {
    setState(() {
      productss.clear();
      for (int i = 0; i < Tickets.length; i++) {
        var value = Tickets[i]["price"].toString() + " EGP";
        var limitt = Tickets[i]["maximum_trips"].toString() + " Stations";
        Productt ticket = Productt(
            limitt, value, Tickets[i]["id"], Tickets[i]["maximum_trips"],
            Tickets[i]["price"]);
        productss.add(ticket);
      }
    });
  }


  var price;

  Future<bool> BuyTicket() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print("Price :" + price.toString());
    });
    var jsonResponse;
    Map<String, String> queryParams = {
      'price': price.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var Url = "http://localhost:8080/BuyTicket" +
        '?' +
        queryString;
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });

    setState(() {
      print(response.statusCode);
    });

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      if (jsonResponse["message"] == "success") {
        await alertDialog("Ticket is purchased", context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavScreen(0)));
      } else {
        await alertDialog("Failed , Check Your Balance", context);
        setState(() {
          print(response.statusCode);
        });
      }
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation Purchase'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Would you like to confirm Buy this Ticket?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                print('Confirmed');
                await BuyTicket();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var ticket;

  @override
  void initState() {
    ticket = GetBasicTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: ticket, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          else {
            return Scaffold
              (
              appBar: buildAppBar("BuyTicket"),
              drawer: MainDrawer(),
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
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
                  arrowbackhome(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 60),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GridView.builder(
                          itemCount: 3,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (context, index) =>
                              card(
                                productss[index],
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

  Container card(products) {
    final Productt product1 = products;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Expanded(
          //child:
          Container(
            alignment: Alignment.bottomCenter,
            height: 135,
            width: 135,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("images/ticket.png")),
                Text(
                  "___________",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${product1.stations}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Segoe UI'),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${product1.price} ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: 0.0, top: 0.0, right: 0, bottom: 10.0),
            height: 50,
            width: 135,
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: () {
                setState(() async {
                  price = product1.value;
                  await _showMyDialog();
                });
              },
              //padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              color: const Color(0xffa80f14),
              child: Text(
                "Buy",
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
    );
  }
}
