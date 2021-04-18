import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:metro_flutter_app/view/station_list.dart';

class GetRoute extends StatefulWidget {
  @override
  _GetRouteState createState() => _GetRouteState();
}

class _GetRouteState extends State<GetRoute> {
  String source;
  String destination;
  bool shortFlag = false;
  bool fullFlag = false;
  final _formKey1 = GlobalKey<FormState>();

  List<Station> shortRoute = [
    Station(
      stationName: 'Bahoos',
      state: false,
    ),
    Station(
      stationName: 'Saddat',
      state: true,
      direction: 'Helwan Way',
    ),
    Station(
      stationName: 'Saad Zaghloul',
      state: false,
    ),
  ];
  List<Station> fullRoute = [
    Station(
      stationName: 'Bahoos',
      state: false,
    ),
    Station(
      stationName: 'Dokki',
      state: false,
    ),
    Station(
      stationName: 'Opera',
      state: false,
    ),
    Station(
      stationName: 'Saddat',
      state: true,
      direction: 'Helwan Way',
    ),
    Station(
      stationName: 'Saad Zaghloul',
      state: false,
    ),
  ];

  void _getFullRoute() {
    setState(() {
      fullFlag = true;
      shortFlag = false;
    });
  }

  void _getShortRoute() {
    setState(() {
      shortFlag = true;
      fullFlag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          margin: EdgeInsets.only(top: 0, bottom: 0),
          height: screenHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).viewPadding.top -
              MediaQuery.of(context).viewPadding.bottom,
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
          child: Form(
            key: _formKey1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
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
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey1.currentState.validate()) {
                      _formKey1.currentState.save();
                      _getShortRoute();
                      try {} catch (error) {}
                    }
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
                        "Get Route",
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
                  height: 10,
                ),
                InkWell(
                  child: Text(
                    'Show Full Route',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  onTap: () {
                    if (_formKey1.currentState.validate()) {
                      _formKey1.currentState.save();
                      _getFullRoute();
                      try {} catch (error) {}
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                if (shortFlag)
                  StationList(shortRoute)
                else if (fullFlag)
                  StationList(fullRoute),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
