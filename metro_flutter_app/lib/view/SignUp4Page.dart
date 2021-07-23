import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:http/http.dart' as http;
import 'package:metro_flutter_app/view/SignUp1Page.dart';

import 'LoginPage.dart';

class SignUp4Page extends StatefulWidget {
  String username;
  String name;
  String email;
  String phoneNumber;
  String dateOfBirth;
  SignUp4Page(this.username, this.name, this.email, this.phoneNumber, this.dateOfBirth);

  @override
  _SignUp4PageState createState() => _SignUp4PageState(username,name,email,phoneNumber,dateOfBirth);
}

class _SignUp4PageState extends State<SignUp4Page> {
  String username;
  String name;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String newPassword;
  String confirmNewPassword;

  bool _obscureText = true;
  bool _obscureText2 = true;
  bool lenghtFlag;
  bool upperFlag;
  bool lowerFlag;
  bool numberFlag;
  bool matchFlag;
  final _formKey = GlobalKey<FormState>();

  _SignUp4PageState(this.username, this.name, this.email, this.phoneNumber, this.dateOfBirth);

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

  Future SignUp(BuildContext context)async
  {
    //SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    var Url = "https://metro-user-api.azurewebsites.net/SignUp";
    var jsonResponse;
    var date=DateTime.parse( dateOfBirth);
    setState(() {
      print(username + " " + newPassword + " "+dateOfBirth+" "+date.toString());
    });

    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "username": username,
          "fullname": name,
          "email": email,
          "password": newPassword,
          "phone_number": phoneNumber,
          "date_of_birth": date.toIso8601String()
        }));
    setState(() {
      print(response.statusCode);
      print("ResponseBody : " + response.body);
    });
    jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      print("ResponseBody : " + response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()
          ));
    }
    else {

      if (jsonResponse["message"] == "Error: Username is already taken!") {
        setState(() {
          print("yesss");
        });
        await alertDialog("Error: Username is already taken!", context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUp1Page()
            ));
      }
      else {
        await alertDialog("Error: Email is already in use!", context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUp1Page()
            ));
      }
      setState(() {
        print(response.statusCode);
      });
    }
  }

  void _checkPasswordValidation() {
    if ((newPassword.length >= 6 && newPassword.length <= 20) ||
        (confirmNewPassword.length >= 6 && confirmNewPassword.length <= 20))
      setState(() {
        lenghtFlag = true;
      });
    else
      setState(() {
        lenghtFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[A-Z]')) &&
        confirmNewPassword.contains(new RegExp(r'[A-Z]')))
      setState(() {
        upperFlag = true;
      });
    else
      setState(() {
        upperFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[a-z]')) &&
        confirmNewPassword.contains(new RegExp(r'[a-z]')))
      setState(() {
        lowerFlag = true;
      });
    else
      setState(() {
        lowerFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[0-9]')) &&
        confirmNewPassword.contains(new RegExp(r'[0-9]')))
      setState(() {
        numberFlag = true;
      });
    else
      setState(() {
        numberFlag = false;
      });

    if (newPassword == confirmNewPassword)
      setState(() {
        matchFlag = true;
      });
    else
      setState(() {
        matchFlag = false;
      });
  }

  void _send() async{
    if (upperFlag && lowerFlag && numberFlag && matchFlag && lenghtFlag) {
      await SignUp(context);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              arrowback(context),
              Image.asset("images/metro-logo.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14), 15.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        onSaved: (val) {
                          this.newPassword = val;
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "This Field couldn't be blank!";
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xd6a80f14)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelStyle: TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          labelText: " Password",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14), 15.0),
                      child: TextFormField(
                        obscureText: _obscureText2,
                        onSaved: (val) {
                          this.confirmNewPassword = val;
                        },
                        validator: (val) {
                          if (val.isEmpty)
                            return "This Field couldn't be blank!";
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xd6a80f14)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                          ),
                          labelStyle: TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          labelText: " Confirm Password",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _checkPasswordValidation();
                          _send();
                          try {} catch (error) {}
                        } else {}
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xFFFFFFFF), 10.0),
                        child: Center(
                          child: Text(
                            "Sign Up",
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
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password should :",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if (lenghtFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (lenghtFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (lenghtFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contain at least 6-20 characters long.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (upperFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (upperFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (upperFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains an upper case letter.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (lowerFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (lowerFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (lowerFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains an lower case letter.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (numberFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (numberFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (numberFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains a number.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (matchFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (matchFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (matchFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Match Confirm Password.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
