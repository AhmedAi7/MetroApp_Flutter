import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/Textfeildd.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String source;
  String destination;
  double balance = 50.75;
  double price = 0.0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              margin: EdgeInsets.only(top: 0, bottom: 0),
              height: screenHight -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context).viewPadding.bottom -
                  kBottomNavigationBarHeight,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 120),
                          //left: 10,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'Recharge');
                                },
                                child: Container(
                                  width: screenWidth * 0.5,
                                  height: (screenHight -
                                          MediaQuery.of(context).padding.top -
                                          AppBar().preferredSize.height) *
                                      0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0xffa80f14),
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
                                      "Recharge",
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
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'MyTickets');
                                },
                                child: Container(
                                  width: screenWidth * 0.5,
                                  height: (screenHight -
                                          MediaQuery.of(context).padding.top -
                                          AppBar().preferredSize.height) *
                                      0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0xffa80f14),
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
                                      "  My Tickets",
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffa80f14),
                              borderRadius: BorderRadius.circular(75),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffa80f14),
                                  offset: Offset(0, 1),
                                  spreadRadius: 0.1,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              maxRadius: 75,
                              backgroundColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    balance.toString(),
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'EGP',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffa80f14),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 60, 5, 5),
                    child: Column(
                      children: [
                        textfield(
                          "Source",
                          Icons.my_location,
                          source,
                          50, //height
                          screenWidth * 0.89, //width
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textfield(
                          "Destination",
                          Icons.location_on_outlined,
                          destination,
                          50,
                          screenWidth * 0.89,
                        ),
                      ],
                    ),
                  ),
                  // here
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 5, 5),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'BuyTickets');
                          },
                          child: Container(
                            width: screenWidth * 0.5,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffa80f14),
                              borderRadius: BorderRadius.circular(10),
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
                                "Buy Ticket",
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                          child: Container(
                            width: screenWidth * 0.25,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffa80f14),
                                  offset: Offset(0, 1),
                                  spreadRadius: -2,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                price.toString() + " EGP",
                                style: TextStyle(
                                  color: Color(0xffa80f14),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}