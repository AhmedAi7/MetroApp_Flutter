import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:intl/intl.dart';

import 'HomeSplash.dart';

class SettingsSplash extends StatefulWidget {
  @override
  _SettingsSplashState createState() => _SettingsSplashState();
}

class _SettingsSplashState extends State<SettingsSplash>  {

  String newFullName;
  String newDateOfBirth;
  DateTime selectedDate = DateTime.now();
  final _textEditingController = TextEditingController();
  String fullname;
  String email;
  String phone;
  String dateofbirth;

  var user;

  @override
  void initState() {
    user = getUser();
    super.initState();
  }

  Future getUser()async
  {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    setState(() {
      fullname=sharedPreferences.getString("fullname");
      email=sharedPreferences.getString("email");
      phone=sharedPreferences.getString("phone_number");
      dateofbirth=sharedPreferences.getString("date_of_birth");

    });

  }
  void _changeUserName() {
    if (newFullName == null) return;
    setState(() {
      print("newFullName");
      changeUserName(newFullName);
    });
    Navigator.pop(context);
  }

  void _changeDateOfBirth() {
    if (newDateOfBirth == null) return;
    setState(() {
      changeDateOfBirth(newDateOfBirth);
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
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1921, 1, 1),
            maxTime: DateTime(2121, 12, 31), onConfirm: (date) {
              final formattedStr = DateFormat.yMMMd().format(date);
              newDateOfBirth = formattedStr.toString();
              //String x = date.;
              _changeDateOfBirth();
            }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );
  }
  int counter =0;
  @override
  Widget build(BuildContext context) {
    while (counter == 0) {
      getUser();
      setState(() {
        counter = counter + 1;
      });
    }
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return FutureBuilder<dynamic>(
        future: user, // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<
                dynamic> snapshot) { // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          else {
           return Scaffold(
              body: SingleChildScrollView(
                //physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height -
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
                                          decoration:
                                          CustomBoxDecoration.decorationStyle(
                                            Color(0xffa80f14),
                                            15.0,
                                          ),
                                          child: TextFormField(
                                            controller: _textEditingController,
                                            keyboardType: TextInputType
                                                .emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration:
                                            CustomInputDecoration
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xffa80f14),
                                                borderRadius: BorderRadius
                                                    .circular(10),
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
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontStyle: FontStyle
                                                          .italic,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  newFullName =
                                                      _textEditingController
                                                          .text;
                                                  _changeUserName();
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
                              Navigator.of(context).pushNamed(
                                  'EditPhoneNumber');
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
        }
    );
  }
}
