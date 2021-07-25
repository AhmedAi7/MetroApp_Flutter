import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:http/http.dart' as http;
import 'package:metro_flutter_app/component/User_Status.dart';
import 'package:metro_flutter_app/models/LoginRequest.dart';
import 'package:metro_flutter_app/view/HomeSplash.dart';
import 'package:metro_flutter_app/view/NavgPage.dart';
import 'package:metro_flutter_app/view/get_route.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;

  String password;
  static var response;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

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

  Future Login(String username, String password, BuildContext context) async {
    //SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    var Url = "http://localhost:8080/Login";
    var jsonResponse;
    setState(() {
      print(username + " " + password);
    });
    response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(
            <String, String>{"username": username, "password": password}));
    setState(() {
      print(response.statusCode);
    });

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      //loginStatues.writeStatus(true);
      loginStatues.writetoken(jsonResponse["Authorization"]);
       Navigator.push(
           context, MaterialPageRoute(builder: (context) => NavScreen(0)));
    } else {
      await alertDialog("UserName or Password isn't correct!", context);
      setState(() {
        print(response.statusCode);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Background.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("images/metro-logo.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xffa80f14), 15.0),
                      child: TextFormField(
                        onSaved: (val) {
                          setState(() {
                            this.username = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "UserName couldn't be blank!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: CustomInputDecoration.textFieldStyle(
                            " UserName", Icon(Icons.verified_user)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xffa80f14), 15.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        onSaved: (val) {
                          setState(() {
                            this.password = val;
                          });
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Password couldn't be blank!";
                          }
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
                            borderSide: BorderSide(color: Color(0xffa80f14)),
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
                      height: 25,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            LoginRequestModel model =
                                await Login(username, password, context);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid User !'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  print('Action in Snackbar has been pressed.');
                                },
                              )));
                        }
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xFFFFFFFF), 10.0),
                        child: Center(
                          child: Text(
                            "Login",
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
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFE5E5E5)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'SignUp1');
                    },
                    child: Text(
                      '  Sign Up  ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFE5E5E5)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
