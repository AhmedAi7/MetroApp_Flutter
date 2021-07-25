import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'HomeSplash.dart';

class SettingsSplash extends StatefulWidget {
  @override
  _SettingsSplashState createState() => _SettingsSplashState();
}

class _SettingsSplashState extends State<SettingsSplash> {
  String newFullName;
  String newDateOfBirth;
  DateTime selectedDate = DateTime.now();
  final _textEditingController = TextEditingController();
  String fullname;
  String email;
  String phone;
  String dateofbirth;

  var user;
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

  @override
  void initState() {
    user = getUser();
    super.initState();
  }

  Future changeUserNamee(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    Map<String, String> queryParams = {
      'newName': newFullName,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var Url = "http://localhost:8080/ChangeUserName" + '?' + queryString;

    var jsonResponse;
    var response = await http.post(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      setState(() {
        sharedPreferences.setString("fullname", newFullName);
      });
      await alertDialog("Full Name updated successfully", context);
      Navigator.popAndPushNamed(context, "Settings");
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  Future changeDateOfBirth(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });

    var date = DateTime.parse(newDateOfBirth);
    setState(() {
      print(date.toIso8601String());
    });

    var Url = "http://localhost:8080/ChangeUserBirthDate";

    var jsonResponse;
    var response = await http.post(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    },
        body: jsonEncode(<String, dynamic>{
        'newDate': date.toIso8601String()
        }));

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      setState(() {
        sharedPreferences.setString("date_of_birth", newDateOfBirth);
      });
      await alertDialog("Date of Birth updated successfully", context);
      Navigator.popAndPushNamed(context, "Settings");
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  Future getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullname = sharedPreferences.getString("fullname");
      email = sharedPreferences.getString("email");
      phone = sharedPreferences.getString("phone_number");
      dateofbirth = sharedPreferences.getString("date_of_birth");
    });
  }

  InkWell _editDate() {
    return InkWell(
      child: Text(
        'Edit',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 15,
        ),
      ),
      onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context)
                  .requestFocus(new FocusNode());
              date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              setState(() {
                newDateOfBirth = date.toString().substring(0, 10);
              });
              await changeDateOfBirth(context);
            },
    );
  }

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    while (counter == 0) {
      getUser();
      setState(() {
        counter = counter + 1;
      });
    }
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<dynamic>(
        future: user, // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                //physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).viewPadding.top -
                      MediaQuery.of(context).viewPadding.bottom -
                      kBottomNavigationBarHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffD3D3D3),
                  ),
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '      Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '              Full Name',
                        style: TextStyle(
                          color: Color(0xff656565),
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '         ' + fullname,
                        style: TextStyle(
                          color: Color(0xffa80f14),
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.7,
                          ),
                          InkWell(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200, // height modal bottom
                                    color: Color(0xffD3D3D3),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: screenWidth * 0.89,
                                          decoration: CustomBoxDecoration
                                              .decorationStyle(
                                            Color(0xffa80f14),
                                            15.0,
                                          ),
                                          child: TextFormField(
                                            controller: _textEditingController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: CustomInputDecoration
                                                .textFieldStyle(
                                              "New Full Name",
                                              Icon(Icons.perm_identity),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xffa80f14),
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    'Apply',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  newFullName =
                                                      _textEditingController
                                                          .text;
                                                  await changeUserNamee(
                                                      context);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              child: Text(
                                                'Close  ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '              Phone Number',
                        style: TextStyle(
                          color: Color(0xff656565),
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '         ' + phone,
                        style: TextStyle(
                          color: Color(0xffa80f14),
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.7,
                          ),
                          InkWell(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              // navigate to change phone number
                              Navigator.of(context)
                                  .pushNamed('EditPhoneNumber');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '              Email',
                        style: TextStyle(
                          color: Color(0xff656565),
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '         ' + email,
                        style: TextStyle(
                          color: Color(0xffa80f14),
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.7,
                          ),
                          InkWell(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              // navigate to change email
                              Navigator.of(context).pushNamed('EditEmail');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '              Date of Birth',
                        style: TextStyle(
                          color: Color(0xff656565),
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '         ' + dateofbirth,
                        style: TextStyle(
                          color: Color(0xffa80f14),
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.7,
                          ),
                          _editDate(),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '      Security',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'ResetPassword');
                        },
                        child: Text(
                          '         Reset Password',
                          style: TextStyle(
                            color: Color(0xffa80f14),
                            fontFamily: 'Segoe UI',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '      About Us',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Segoe UI',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'ContactUs');
                        },
                        child: Text(
                          '         Contact Us',
                          style: TextStyle(
                            color: Color(0xffa80f14),
                            fontFamily: 'Segoe UI',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
