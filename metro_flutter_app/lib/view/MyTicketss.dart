import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/TicketsTypes.dart';
import 'package:metro_flutter_app/models/UserTickets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'HomeSplash.dart';

class MyTickets extends StatefulWidget {
  @override
  _MyTicketsState createState() => _MyTicketsState();
}

List<dynamic> Tickets;
List<dynamic> Ticketsss;

class _MyTicketsState extends State<MyTickets> {
  Future<bool> GetTickets() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    //http://localhost:8080
    var Url = "http://localhost:8080/GetUserTickets";
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });

    if (response.statusCode == 200) {
      // final j="[" + response.body + "]";
      jsonResponse = jsonDecode(response.body);
      print("Response" + jsonResponse["tickets_data"].toString());
      setState(() {
        Tickets = jsonResponse["tickets_data"];
        _Set_Tickets();
        print("Tickets" + Tickets.toString());
      });
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

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
        Ticketsss = jsonResponse["Basic Tickets:"];
        Set_Tickets();
        print("Tickets" + Ticketsss.toString());
      });
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }
  void Set_Tickets()
  {
    setState(() {
      for (int i = 0; i < Ticketsss.length; i++) {
         int k=i+1;
        var value =  "Tickets Type $k"; //Ticketsss[i]["price"].toString() + " EGP
        cat.add(value);
      }});
  }
  void _Set_Tickets() {
    setState(() {
      ListType.clear();
      List<int> prices=[];
      Tickets.sort((a, b) => a["price"].compareTo(b["price"]));
      for (int i = 0; i < Tickets.length; i++) {
        List<Tickett> Ticketts=new List<Tickett>();
        Tickett ticket = Tickett(Tickets[i]["id"], Tickets[i]["price"],
            Tickets[i]["maximumTrips"], Tickets[i]["source_station"]);
        if (!prices.contains(Tickets[i]["price"])) {
          print("yes "+Tickets[i]["price"].toString());
          prices.add(Tickets[i]["price"]);
          Ticketts.add(ticket);
          ListType.add(Ticketts);
        }
        else
          {
            print("no");
            for(int i=0;i<prices.length;i++) {
            if(prices[i]==Tickets[i]["price"])
              {
               ListType[i].add(ticket);
              }
          }
         }
      }
    });
  }

  static int selectedindex = 0;
  List<String> cat = [];
  int counter = 0;
  var ticket;

  // @override
  // void initState() {
  //   ticket = GetTickets();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (counter == 0) {
      setState(() {
        GetBasicTickets();
        GetTickets();
        counter++;
      });
    }
    // return FutureBuilder<dynamic>(
    //     future: ticket, // function where you call your api
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       // AsyncSnapshot<Your object type>
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return SplashScreen();
    //       }
    //       else {
            return Scaffold(
              appBar: buildAppBar("My Tickets"),
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
                  buildchoices(cat),
                  SizedBox(height: 25.0),
                  girdView(),
                ],
              ),
            );
    //       }
    //     }
    // );
  }

  Padding girdView() {
    int count=0;
    List<Tickett> k=[];
    setState(() {

      if(selectedindex<ListType.length) {
        print(ListType[selectedindex][0].price);
          k = ListType[selectedindex];
          count = ListType[selectedindex].length;
        cat[selectedindex].replaceAll( cat[selectedindex].split(" ")[0],ListType[selectedindex][0].price.toString());
      }
      // if (selectedindex == 0) {
      //   count = Tickets_five.length;
      //   k = Tickets_five;
      // } else if (selectedindex == 1) {
      //   count = Tickets_seven.length;
      //   k = Tickets_seven;
      // } else if (selectedindex == 2) {
      //   count = Tickets_ten.length;
      //   k = Tickets_ten;
      // }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 90),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: GridView.builder(
            itemCount: count,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => card(
              k[index],
            ),
          ),
        ),
      ),
    );
  }

  Container card(products) {
    final Tickett product1 = products;
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
                  "${product1.maximum_trips.toString() + " Stations"}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${product1.price.toString() + " EGP"} ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
              onPressed: () => Navigator.pushNamed(context, "UseTickets"),
              //padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              color: const Color(0xffa80f14),
              child: Text(
                "Use",
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
          )
        ],
      ),
    );
  }

  Padding buildchoices(List<String> cat) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefulpadding, vertical: 45),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedindex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefulpadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 110,
                    decoration: BoxDecoration(
                      color: selectedindex == index
                          ? Color(0xffa80f14)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 1),
                          spreadRadius: -2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        cat[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: selectedindex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: selectedindex == index
                        ? Colors.black
                        : Colors.transparent,
                    height: 2,
                    width: 30,
                    margin: EdgeInsets.only(top: kDefulpadding / 4),
                  )
                ],
              ),
            ),
          ),
          itemCount: cat.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

