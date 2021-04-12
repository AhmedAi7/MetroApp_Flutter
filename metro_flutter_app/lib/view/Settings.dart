import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/user.dart';
import '../models/user.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
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
                '         ' + user.email,
                style: TextStyle(
                  color: Color(0xffa80f14),
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                ),
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
                  Navigator.pushNamed(context, 'UpdateInfo');
                },
                child: Text(
                  '         Update Info',
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
