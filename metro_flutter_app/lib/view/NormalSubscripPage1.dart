import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/Lines.dart';
import 'package:metro_flutter_app/models/SubTypes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:metro_flutter_app/helpers/location_helper.dart';
import 'package:metro_flutter_app/models/place.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map_screen.dart';
import 'NormalSubscripPage2.dart';
import 'package:http/http.dart' as http;

class Item {
  const Item(this.name, this.icon, this.period);
  final String name;
  final Icon icon;
  final int period;
}

class NormalSubscription1 extends StatefulWidget {
  NormalSubscription1();

  @override
  _NormalSubscription1State createState() => _NormalSubscription1State();
}

class _NormalSubscription1State extends State<NormalSubscription1> {
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

  Future GetSubscriptionPrice(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(source + " " + destination + " ");
      print(selected_user.period);
      print(token);
    });

    Map<String, String> queryParams = {
      'source': source,
      'target': destination,
      'period': selected_user.period.toString()
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var Url = "http://localhost:8080/GetSubscriptionPrice" + '?' + queryString;

    var jsonResponse;
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      setState(() {
        price = jsonResponse["price"];
      });
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  String source;
  String destination;
  String period;
  double balance = 50.75;
  String price = "0.0";
  String _previewImageUrl;
  bool flag = false;
  // ignore: unused_field
  PlaceLocation _pickedLocation;
  String _nearestStation = "Al-Sayeda Zainab";

  List<String> stations1 = [];
  List<int> lines = [];

  void linesId() {
    lines.clear();
    setState(() {
      StationLine.forEach((k, v) {
        if (!lines.contains(v)) {
          lines.add(v);
        }
      });
    });
  }

  void Stations() {
    setState(() {
      StationLine.forEach((k, v) {
        stations1.add(k);
      });
      stations1.sort();
    });
  }

  Map StationLine = new HashMap<String, dynamic>();
  Future GetStations(int type, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });
    var jsonResponse;
    var Url = "http://localhost:8080/GetAllStations";
    var response = await http.get(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      print("ResponseBody : " + response.body);
      liness.clear();
      stations1.clear();
      StationLine = jsonResponse["stations"];
      Stations();
      ExpansionTile L =
          Line("0", _getChildren(stations1.length, stations1, type, 0));
      // Linee S= Linee(id : i,stations: st);
      // Stationlinee.add(S);
      liness.add(L);
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  List _getChildren(int count, List<String> stationss, int type, int id) =>
      List<Widget>.generate(
        count,
        (i) => ListTile(
          leading: Icon(
            Icons.directions_train_sharp,
            color: Color(0xffa80f14),
            size: 25,
          ),
          title: TextButton(
            child: Text(
              stationss[i],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            onPressed: () {
              if (type == 1) {
                setState(() {
                  source = stationss[i];
                });
              } else {
                setState(() {
                  destination = stationss[i];
                });
              }
              setState(() {
                // print("1: "+liness[0].children.length.toString());
                // print("2: "+liness[1].children.length.toString());
                // print("3: "+liness[2].children.length.toString());
                Navigator.pop(context);
              });
            },
          ),
        ),
      );

  List<ExpansionTile> liness = [];
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
              itemCount: liness.length,
              itemBuilder: (BuildContext context, int index) {
                return liness[index];
              }),
        );
      },
    );
  }

  static List<Item> Periods = <Item>[
    const Item(
        '1 Month',
        Icon(
          Icons.date_range,
          color: const Color(0xffa80f14),
        ),
        1),
    const Item(
        '3 Months',
        Icon(
          Icons.date_range,
          color: const Color(0xffa80f14),
        ),
        3),
    const Item(
        '1 year',
        Icon(
          Icons.date_range,
          color: const Color(0xffa80f14),
        ),
        12),
  ];
  Item selected_user = Periods[0];

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      //appBar: buildAppBar(),
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
          arrowback(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 60),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
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
                              child: Padding(
                                padding: EdgeInsets.only(top: 15, left: 10),
                                child: Text(
                                  source == null ? "Source" : source,
                                  style: TextStyle(
                                    color: source == null
                                        ? Colors.grey.withOpacity(0.3)
                                        : Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: source == null ? 15 : 20,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              await GetStations(1, context);
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
                              child: Padding(
                                padding: EdgeInsets.only(top: 15, left: 10),
                                child: Text(
                                  destination == null
                                      ? "Destination"
                                      : destination,
                                  style: TextStyle(
                                    color: destination == null
                                        ? Colors.grey.withOpacity(0.3)
                                        : Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: destination == null ? 15 : 20,
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
                            onTap: () async {
                              await GetStations(2, context);
                              _showLocation(2);
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Container(
                          width: screenWidth * 0.85,
                          height: 50,
                          decoration: BoxDecoration(
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
                          child: Padding(
                            padding: EdgeInsets.only(top: 7, left: 10),
                            child: DropdownButton<Item>(
                              focusColor: Colors.transparent,
                              isExpanded: true,
                              hint: Text("Select Period"),
                              value: selected_user,
                              onChanged: (Item Value) {
                                setState(() {
                                  selected_user = Value;
                                });
                              },
                              items: Periods.map((Item user) {
                                return DropdownMenuItem<Item>(
                                  value: user,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(user.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                user.name == null ? 15 : 20,
                                          )),
                                      user.icon,
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(35, 15, 5, 5),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                await GetSubscriptionPrice(context);
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
                                    "Show Price",
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
                                    price + " EGP",
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
                      ),
                      SizedBox(height: 5.0),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            try {
                              if (source != null && destination != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NormalSubscription2(
                                          source,
                                          destination,
                                          selected_user.period),
                                    ));
                              } else {
                                await alertDialog(
                                    "Check Empty Fields", context);
                              }
                            } catch (e) {}
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
                                "Subscripe",
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
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
  //
  // Container card(products,int index) {
  //   final Product product1 = products;
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         //Expanded(
  //         //child:
  //         Container(
  //           alignment: Alignment.bottomCenter,
  //           height: 135,
  //           width: 144,
  //           padding: EdgeInsets.all(5),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(16),
  //               topRight: Radius.circular(16),
  //             ),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 "${product1.trips} ",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                   fontStyle: FontStyle.italic,
  //                   fontWeight: FontWeight.w600,
  //                   fontFamily: 'Segoe UI',
  //                 ),
  //               ),
  //               Text(
  //                 "${product1.stations}",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                   fontStyle: FontStyle.italic,
  //                   fontWeight: FontWeight.w600,
  //                   fontFamily: 'Segoe UI',
  //                 ),
  //               ),
  //               Text(
  //                 "${product1.months} ",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                   fontStyle: FontStyle.italic,
  //                   fontWeight: FontWeight.w600,
  //                   fontFamily: 'Segoe UI',
  //                 ),
  //               ),
  //               Text(
  //                 "___________",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               Text(
  //                 "${product1.price} ",
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black,
  //                   fontStyle: FontStyle.italic,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         Container(
  //           padding:
  //               EdgeInsets.only(left: 0.0, top: 0.0, right: 0, bottom: 10.0),
  //           height: 50,
  //           width: 144,
  //           // ignore: deprecated_member_use
  //           child: RaisedButton(
  //             onPressed: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => NormalSubscription2(),
  //               ),
  //             ),
  //             //padding: EdgeInsets.all(15.0),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.only(
  //                 bottomRight: Radius.circular(30.0),
  //                 bottomLeft: Radius.circular(30.0),
  //               ),
  //             ),
  //             color: const Color(0xffa80f14),
  //             child: Text(
  //               "Subscripe",
  //               style: TextStyle(
  //                 fontSize: 22,
  //                 fontStyle: FontStyle.italic,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Segoe UI',
  //                 letterSpacing: 1.5,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
