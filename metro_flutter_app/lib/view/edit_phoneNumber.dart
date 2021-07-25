import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EditPhoneNumber extends StatefulWidget {
  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  String newPhoneNumber;

  String password;

  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();

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

  Future changePhoneNumber(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(token);
    });
    Map<String, String> queryParams = {
      'password': password,
      'Atrr': newPhoneNumber,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var Url = "http://localhost:8080/ChangeUserPhoneNum" + '?' + queryString;

    var jsonResponse;
    var response = await http.post(Uri.parse(Url), headers: <String, String>{
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      if (jsonResponse["message"] == "User Phone Number updated successfully") {
        setState(() {
          sharedPreferences.setString("phone_number", newPhoneNumber);
        });
        await alertDialog("User Phone Number updated successfully", context);
        Navigator.popAndPushNamed(context, "Settings");
      }
    } else {
      setState(() {
        print(response.statusCode);
      });
      await alertDialog("Password is wrong , try again", context);
      Navigator.popAndPushNamed(context, "Settings");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar("Edit PhoneNumber"),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
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
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.89,
                  decoration: CustomBoxDecoration.decorationStyle(
                      Color(0xd6a80f14), 15.0),
                  child: TextFormField(
                    onSaved: (val) {
                      this.newPhoneNumber = val;
                    },
                    validator: (val) {
                      if (val.isEmpty) {
                        return "This field couldn't be blank!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: CustomInputDecoration.textFieldStyle(
                      "New Phone Number",
                      Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
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
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await changePhoneNumber(context);
                      try {} catch (error) {}
                    }
                  },
                  child: Container(
                    width: screenWidth * 0.5,
                    height: (screenHeight -
                            MediaQuery.of(context).padding.top -
                            AppBar().preferredSize.height) *
                        0.08,
                    decoration: BoxDecoration(
                      color: Color(0xffa80f14),
                      borderRadius: BorderRadius.circular(20),
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
                        "Apply",
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
        ),
      ),
    );
  }
}
