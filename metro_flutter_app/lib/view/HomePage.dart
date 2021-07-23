import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:metro_flutter_app/component/User_Status.dart';
import 'package:metro_flutter_app/helpers/location_helper.dart';
import 'package:metro_flutter_app/models/Lines.dart';
import 'package:metro_flutter_app/models/place.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeSplash.dart';
import 'map_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  // _HomePageState()
  // {
  //   setState(() async{
  //     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  //   this.balance= sharedPreferences.getString("balance") as double;
  // });
  // }
  Future GetUser(BuildContext context)async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
    String token="Bearer "+sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    var Url="https://metro-user-api.azurewebsites.net/GetUser";
    var response =await http.get(Uri.parse(Url),
        headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});
    if(response.statusCode==200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : "+response.body);
      print("Response :"+jsonResponse["balance"]);
      setState(() {
        loginStatues().setUser(jsonResponse["fullname"], jsonResponse["email"], jsonResponse["password"], jsonResponse["phone_number"], jsonResponse["date_of_birth"],jsonResponse["balance"]);
        balance=double.parse(jsonResponse["balance"]);
        assert(balance is double);
      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
  }
  List listid=[];

  Future GetLinesId()async
  { var jsonResponse;
    var Url2="https://metro-user-api.azurewebsites.net/GetAllLines";
    var response=await http.get(Uri.parse(Url2),
        headers: <String,String>{"Content-Type":"application/json"});
    if(response.statusCode==200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : "+response.body);
      setState(() {
        listid=jsonResponse["lines"];
      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
    }
    List <String> stations=[];
  Future GetLines(int id,int type,BuildContext context)async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
    String token="Bearer "+sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var jsonResponse;
    Map<String, String> queryParams = {
      'id': id.toString(),
    };

    String queryString = Uri(queryParameters: queryParams).query;
    var Url = "https://metro-user-api.azurewebsites.net/GetLineStations" + '?' + queryString;
    var response =await http.get(Uri.parse(Url),
        headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});
    if(response.statusCode==200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : "+response.body);
      setState(() {
       stations=jsonResponse["Stations"];
       lines.add(Line(id.toString(), _getChildren(stations.length, stations,type)));
      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
  }
  Future GetTicketPrice(BuildContext context)async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
    String token="Bearer "+sharedPreferences.getString("token");
    setState(() {
      print(source+" "+destination+" ");
      print(token);
    });

    Map<String, String> queryParams = {
      'source': source,
      'destination': destination,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var Url = "https://localhost:8080/GetTicketPrice" + '?' + queryString;

    var jsonResponse;
    var response =await http.get(Uri.parse(Url),
        headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});
    if(response.statusCode==200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : "+response.body);
      setState(() {
        price=jsonResponse["ticket_price"];
      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  String source;
  String destination;
  double balance = 0.0;
  int price = 0;
  String _previewImageUrl;
  bool flag = false;
  // ignore: unused_field
  PlaceLocation _pickedLocation;
  String _nearestStation = "Al-Sayeda Zainab";

  List _getChildren(int count, List<String> stations, int type) =>
      List<Widget>.generate(
        count,
            (i) => ListTile(
          leading: Icon(
            Icons.directions_train_sharp,
            color: Color(0xffa80f14),
            size: 25,
          ),
          title: InkWell(
            child: Text(
              '${stations[i]}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {
              if (type == 1) {
                source = stations[i];
                _checkPrice();
              } else {
                destination = stations[i];
                _checkPrice();
              }
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
      );
 List<ExpansionTile> lines=[];
  _showStations(int type) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).viewPadding.top -
              MediaQuery.of(context).viewPadding.bottom, // height modal bottom
          color: Color(0xffD3D3D3),
          child: ListView.builder(
              itemCount:lines.length ,
              itemBuilder: (BuildContext context, int index) {
                return lines[index];
              }
          ),
        );
      },
    );
  }


  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    _previewImageUrl = staticMapImageUrl;
  }

  Future<void> _getCurrentLocation(StateSetter st) async {
    try {
      // ignore: unused_local_variable
      final locData = await Location().getLocation().then((value) {
        _showPreview(value.latitude, value.longitude);
        _selectPlace(value.latitude, value.longitude);
        st(() {
          flag = true;
        });
      });
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap(StateSetter st) async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (cxt) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    _selectPlace(selectedLocation.latitude, selectedLocation.longitude);
    st(() {
      flag = true;
    });
    // selectedLocation has longitude and latitude of the location which the user had selected
    //print(selectedLocation.latitude);
  }

  void _checkPrice() async {
    if (source != null && destination != null) {
            GetTicketPrice(context);
    }
  }

  void _set(String str, int type) {
    if (type == 1)
      source = str;
    else
      destination = str;

    Navigator.of(context).pop();
  }

  _showLocation(int type) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter st) {
            return Container(
              height: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context)
                      .viewPadding
                      .bottom, // height modal bottom
              color: Color(0xffD3D3D3),
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).viewPadding.top -
                          MediaQuery.of(context).viewPadding.bottom -
                          kBottomNavigationBarHeight) *
                          0.3,
                      width: MediaQuery.of(context).size.width * 0.88,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFCDCDCD),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffa80f14),
                            offset: Offset(0, 1),
                            spreadRadius: -1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: _previewImageUrl == null
                          ? Text(
                        'No Loaction is Selected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                          : Image.network(
                        _previewImageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton.icon(
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Current Location',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            _getCurrentLocation(st);
                            //flag = true;
                          },
                        ),
                        // ignore: deprecated_member_use
                        FlatButton.icon(
                          icon: Icon(
                            Icons.map,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Select on Map',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            _selectOnMap(st);
                          },
                        ),
                      ],
                    ),
                    if (flag)
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.88,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/walk.png"),
                                alignment: Alignment.centerRight,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffa80f14),
                                  offset: Offset(0, 1),
                                  spreadRadius: 0.1,
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '  Nearest Station: ',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffa80f14),
                                  ),
                                ),
                                Text(
                                  '  ' + _nearestStation,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              _set(_nearestStation, type);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
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
                              child: InkWell(
                                child: Center(
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (type == 1)
                                      source = _nearestStation;
                                    else
                                      destination = _nearestStation;
                                    flag = false;
                                    _previewImageUrl = null;
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      flag = false;
      _previewImageUrl = null;
    });
  }
  int counter =0;
  @override
  Widget build(BuildContext context) {
    while (counter == 0) {
      GetUser(context);
      setState(() {
        counter = counter + 1;
      });
    }
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
              return Scaffold(
                body: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        height: screenHeight -
                            AppBar().preferredSize.height -
                            MediaQuery
                                .of(context)
                                .viewPadding
                                .top -
                            MediaQuery
                                .of(context)
                                .viewPadding
                                .bottom -
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
                                // ignore: deprecated_member_use
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
                                            Navigator.pushNamed(
                                                context, 'Recharge');
                                          },
                                          child: Container(
                                            width: screenWidth * 0.5,
                                            height: (screenHeight -
                                                MediaQuery
                                                    .of(context)
                                                    .padding
                                                    .top -
                                                AppBar().preferredSize.height) *
                                                0.08,
                                            decoration: BoxDecoration(
                                              color: Color(0xffa80f14),
                                              borderRadius: BorderRadius
                                                  .circular(20),
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
                                            Navigator.pushNamed(
                                                context, 'MyTickets');
                                          },
                                          child: Container(
                                            width: screenWidth * 0.5,
                                            height: (screenHeight -
                                                MediaQuery
                                                    .of(context)
                                                    .padding
                                                    .top -
                                                AppBar().preferredSize.height) *
                                                0.08,
                                            decoration: BoxDecoration(
                                              color: Color(0xffa80f14),
                                              borderRadius: BorderRadius
                                                  .circular(20),
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: screenWidth * 0.85,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xffa80f14),
                                                offset: Offset(0, 1),
                                                spreadRadius: 0.1,
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 10),
                                            child: Text(
                                              source == null
                                                  ? "Source"
                                                  : source,
                                              style: TextStyle(
                                                color: source == null
                                                    ? Colors.grey.withOpacity(
                                                    0.3)
                                                    : Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: source == null
                                                    ? 15
                                                    : 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          _showStations(1);
                                        },
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.add_location_alt_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          _showLocation(1);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: screenWidth * 0.85,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xffa80f14),
                                                offset: Offset(0, 1),
                                                spreadRadius: 0.1,
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 10),
                                            child: Text(
                                              destination == null
                                                  ? "Destination"
                                                  : destination,
                                              style: TextStyle(
                                                color: destination == null
                                                    ? Colors.grey.withOpacity(
                                                    0.3)
                                                    : Colors.black,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                                fontSize: destination == null
                                                    ? 15
                                                    : 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          _showStations(2);
                                        },
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.add_location_alt_outlined,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          _showLocation(2);
                                        },
                                      )
                                    ],
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
                                      Navigator.pushNamed(
                                          context, 'BuyTickets');
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 5, 5, 5),
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
