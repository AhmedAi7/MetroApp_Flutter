import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/models/user.dart';
import '../models/user.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  String newFullName;
  String newDateOfBirth;
  DateTime selectedDate = DateTime.now();
  void _changeUserName() {
    if (newFullName == null) return;
    setState(() {
      ChangeUserName(newFullName);
    });
  }

  void _changeDateOfBirth() {
    if (newDateOfBirth == null) return;
    setState(() {
      changeDateOfBirth(newDateOfBirth);
    });
  }

  InkWell _buildInkWell(String title, String input, Function change,
      double screenWidth, IconData icon) {
    return InkWell(
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
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  textfield(
                    title,
                    icon,
                    input,
                    50,
                    screenWidth * 0.8,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 30,
                        width: 60,
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
                              'Apply',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            change();
                            Navigator.pop(context);
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
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
          newDateOfBirth = date.toString();
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
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
              Row(
                children: [
                  Text(
                    '         ' + user.name,
                    style: TextStyle(
                      color: Color(0xffa80f14),
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.25,
                  ),
                  _buildInkWell(
                    'New Full Name',
                    newFullName,
                    _changeUserName,
                    screenWidth,
                    Icons.perm_identity,
                  ),
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
              Row(
                children: [
                  Text(
                    '         ' + user.phoneNumber,
                    style: TextStyle(
                      color: Color(0xffa80f14),
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.25,
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
              Row(
                children: [
                  Text(
                    '         ' + user.email,
                    style: TextStyle(
                      color: Color(0xffa80f14),
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                    ),
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
              Row(
                children: [
                  Text(
                    '         ' + user.dateOfBirth,
                    style: TextStyle(
                      color: Color(0xffa80f14),
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.25,
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
}
