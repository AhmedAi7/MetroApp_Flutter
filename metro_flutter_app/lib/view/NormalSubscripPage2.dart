import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/User_Status.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:metro_flutter_app/models/NormalSubscription.dart';
import 'package:metro_flutter_app/models/SubTypes.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NormalSubscription2 extends StatefulWidget {
  String source;
  String target;
  int period;
  NormalSubscription2(this.source, this.target, this.period);

  @override
  _NormalSubscription2State createState() =>
      _NormalSubscription2State(source, target, period);
}

class _NormalSubscription2State extends State<NormalSubscription2> {
  int id = 14;
  final full_name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final national_id = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final source = TextEditingController();
  final target = TextEditingController();
  // Product product=products[index1];
  final _formKey1 = GlobalKey<FormState>();
  bool _obscureText = true;
  _NormalSubscription2State(this.source1, this.target1, this.period);
  String source1;
  String target1;
  int period;

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

  Future AddSubscription(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");
    setState(() {
      print(full_name.text +
          " " +
          email.text +
          " " +
          phone.text +
          " " +
          national_id.text +
          " " +
          country.text +
          " " +
          city.text +
          " " +
          source1 +
          " " +
          target1);
      print(token);
    });
    var Url = "http://localhost:8080/AddNormalSubscription";
    var jsonResponse;
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: token
        },
        body: jsonEncode(<String, dynamic>{
          "full_name": full_name.text,
          "email": email.text,
          "phone": phone.text,
          "national_id": national_id.text,
          "country": country.text,
          "city": city.text,
          "source": source1,
          "target": target1,
          "period": period
        }));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      if (jsonResponse["message"] == "success") {
        await alertDialog("Subscription is Added", context);
        Navigator.popAndPushNamed(context, 'NavgPage');
      } else {
        await alertDialog("Check Your balance or your info", context);
      }
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: buildAppBar("Subscription Form"),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
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
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                child: Form(
                  key: _formKey1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fill the form to apply for\nNormal Subscription :",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Segoe UI',
                            color: const Color(0xffffffff),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Fullname",
                          Icons.perm_contact_cal_sharp,
                          full_name,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Email",
                          Icons.email,
                          email,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Phone Number",
                          Icons.phone,
                          phone,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "National ID",
                          Icons.credit_card,
                          national_id,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textfield(
                              "Country",
                              Icons.location_city,
                              country,
                              55,
                              screenwidth / 2.34,
                            ),
                            textfield(
                              "City",
                              Icons.location_city,
                              city,
                              55,
                              screenwidth / 2.34,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              if (_formKey1.currentState.validate()) {
                                _formKey1.currentState.save();
                                NormalSubscriptionmodel model =
                                    await AddSubscription(context);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Check Your balance or your info'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          print(
                                              'Action in Snackbar has been pressed.');
                                        },
                                      )));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80.0),
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: CustomBoxDecoration.decorationStyle(
                                  Color(0xFFFFFFFF), 10.0),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
