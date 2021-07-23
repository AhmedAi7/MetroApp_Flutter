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

class MyTickets extends StatefulWidget {
  @override
  _MyTicketsState createState() => _MyTicketsState();
}
List<dynamic> Tickets;
class _MyTicketsState extends State<MyTickets> {
  Future<bool> GetTickets()async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
    String token="Bearer "+sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    //http://localhost:8080
    var Url="https://metro-user-api.azurewebsites.net/GetUserTickets";
    var response =await http.get(Uri.parse(Url),
        headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});

    if(response.statusCode==200) {
      // final j="[" + response.body + "]";
      jsonResponse = jsonDecode(response.body);
      print("Response" +jsonResponse["tickets_data"].toString());
      setState(() {
        Tickets=jsonResponse["tickets_data"];
        _Set_Tickets();
        print("Tickets"+ Tickets.toString());
      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
  }
  void _Set_Tickets()
  {
    setState(() {
      Tickets_five.clear();
      Tickets_seven.clear();
      Tickets_ten.clear();
      for (int i = 0; i < Tickets.length; i++) {
        if (Tickets[i]["price"] == 5) {
          Tickett ticket = Tickett(
              Tickets[i]["id"], Tickets[i]["price"], Tickets[i]["maximumTrips"],
              Tickets[i]["source_station"]);
          Tickets_five.add(ticket);
        }
        if (Tickets[i]["price"] == 7) {
          Tickett ticket = Tickett(
              Tickets[i]["id"], Tickets[i]["price"], Tickets[i]["maximumTrips"],
              Tickets[i]["source_station"]);
          Tickets_seven.add(ticket);
        }
        if (Tickets[i]["price"] == 10) {
          Tickett ticket = Tickett(
              Tickets[i]["id"], Tickets[i]["price"], Tickets[i]["maximumTrips"],
              Tickets[i]["source_station"]);
          Tickets_ten.add(ticket);
        }
      }
    });
    }
  static int selectedindex = 0;
  List<String> cat = ["5 EGP Tickets", "7 EGP Tickets", "10 EGP Tickets"];
  int counter=0;
  @override
  Widget build(BuildContext context) {
    if(counter==0) {
      setState(() {
        GetTickets();
        counter++;
      });
    }
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Stack(
        children: [
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
          arrowbackhome(context),
          buildchoices(cat),
          SizedBox(height: 25.0),
          girdView(),
        ],
      ),
    );
  }

  Padding girdView() {
    int count;
    List <Tickett> k;
setState(() {
    if (selectedindex == 0) {
      count = Tickets_five.length;
      k=Tickets_five;
    }
    else if (selectedindex == 1) {
      count = Tickets_seven.length;
      k=Tickets_seven;
    }
    else if (selectedindex == 2) {
      count = Tickets_ten.length;
      k=Tickets_ten;
    }
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
              childAspectRatio: 0.9,
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
                  "${product1.price.toString() +" EGP"} ",
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
