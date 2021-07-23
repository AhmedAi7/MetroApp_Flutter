import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/helpers/location_helper.dart';
import 'package:metro_flutter_app/models/place.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:metro_flutter_app/view/station_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map_screen.dart';
import '../helpers/location_helper.dart';
import 'package:http/http.dart' as http;

class GetRoute extends StatefulWidget {
  @override
  _GetRouteState createState() => _GetRouteState();
}

class _GetRouteState extends State<GetRoute> {
  String source;
  String destination;
  bool shortFlag = false;
  bool fullFlag = false;
  String _previewImageUrl;
  bool flag = false;
 // Map<String,bool> Path1;
  Map Path1 = new HashMap<String, dynamic>();

  // ignore: unused_field
  PlaceLocation _pickedLocation;
  String _nearestStation = "Al-Sayeda Zainab";

  Future<bool> GetPath()async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance() ;
    String token="Bearer "+sharedPreferences.getString("token");
    setState(() {
      print(token);
    });
    Map<String, String> queryParams = {
      'source': source,
      'destination': destination,
    };

    String queryString = Uri(queryParameters: queryParams).query;
    var Url = "https://metro-user-api.azurewebsites.net/GetPath" + '?' + queryString;
    var jsonResponse;
    var response =await http.get(Uri.parse(Url),
        headers: <String,String>{"Content-Type":"application/json", HttpHeaders.authorizationHeader:token});
    if(response.statusCode==200) {
     // final j="[" + response.body + "]";
      jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print("Response" +jsonResponse["path"].toString());
      print(jsonResponse["path"].runtimeType);
      setState(() {
          Path1=jsonResponse["path"] ;
          _setFullRoute();
          _setShortRoute();

      });
    }
    else
    {
      setState(() {
        print(response.statusCode);
      });
    }
  }
  List<Station> shortRoute = [];
  List<Station> fullRoute = [];
  void _getFullRoute() {
    setState(() {
      fullFlag = true;
      shortFlag = false;
    });
  }
  void _setFullRoute()
  {
    fullRoute.clear();
    setState(() {
      Path1.forEach((k, v)
          {
            Station s=Station(stationName: k, state: v, line: 0);
            fullRoute.add(s);
          }
    );
  });
}

  void _setShortRoute()
  {
    shortRoute.clear();
    setState(() {
      for(int i=0;i<fullRoute.length; i++)
        {
           if(i==0||i==fullRoute.length-1 ||fullRoute[i].state==true)
             {
               shortRoute.add(fullRoute[i]);
             }
        }
    });
  }
  void _getShortRoute() {
    setState(() {
      shortFlag = true;
      fullFlag = false;
    });
  }

  bool _checkValidate() {
    if (source == null || destination == null)
      return false;
    else
      return true;
  }

  List _getChildren(int count, List<Station> stations, int type) =>
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
              '${stations[i].stationName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {
              if (type == 1)
                source = stations[i].stationName;
              else
                destination = stations[i].stationName;
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
      );

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
          child: ListView(
            children: [
              ExpansionTile(
                title: Text(
                  'Line 1',
                  style: TextStyle(
                    color: Color(0xffa80f14).withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                children:
                    _getChildren(stationsLine1.length, stationsLine1, type),
              ),
              ExpansionTile(
                title: Text(
                  'Line 2',
                  style: TextStyle(
                    color: Color(0xffa80f14).withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                children:
                    _getChildren(stationsLine2.length, stationsLine2, type),
              ),
              ExpansionTile(
                title: Text(
                  'Line 3',
                  style: TextStyle(
                    color: Color(0xffa80f14).withOpacity(0.8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                children:
                    _getChildren(stationsLine3.length, stationsLine3, type),
              ),
            ],
          ),
        );
      },
    );
  }

  void _set(String str, int type) {
    if (type == 1)
      source = str;
    else
      destination = str;

    Navigator.of(context).pop();
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
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: screenWidth * 0.75,
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
                            width: screenWidth * 0.75,
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
                          onTap: () {
                            _showLocation(2);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: ()async {
                    if (_checkValidate()) {
                      await GetPath();
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
                    if (_checkValidate()) {
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
