import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChargeWallet extends StatefulWidget {
  @override
  _ChargeWalletState createState() => _ChargeWalletState();
}

class _ChargeWalletState extends State<ChargeWallet> {
  String expireDate, expireYear;
  TextEditingController dateCtl = TextEditingController();
  final Credit_number = TextEditingController();
  final Cvvnumber = TextEditingController();
  final Amount = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();
  Future ChargeWallett(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = "Bearer " + sharedPreferences.getString("token");

    var Url = "http://localhost:8080/charges";
    var jsonResponse;
    var exp_month = int.parse(dateCtl.text.split("-")[1]);
    assert(exp_month is int);
    var exp_year = int.parse(dateCtl.text.split("-")[0]);
    assert(exp_year is int);
    var amount = int.parse(Amount.text);
    assert(amount is int);

    setState(() {
      print(Credit_number.text +
          " " +
          Cvvnumber.text +
          " " +
          exp_month.toString() +
          " " +
          exp_year.toString() +
          " " +
          amount.toString());
      print(token);
    });
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: token
        },
        body: jsonEncode(<String, dynamic>{
          "amount": amount,
          "cardnum": Credit_number.text,
          "cvv": Cvvnumber.text,
          "exp_month": exp_month,
          "exp_year": exp_year,
        }));
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("ResponseBody : " + response.body);
      if (jsonResponse["message"] == "Balance Charged Successfully") {
        await alertDialog("Balance Charged Successfully", context);
        Navigator.pushNamed(context, "HomePage");
      } else {
        await alertDialog("Check Your balance or your info", context);
      }
    } else {
      setState(() {
        print(response.statusCode);
      });
    }
  }

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

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar("Charge Wallet"),
      drawer: MainDrawer(),
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
            arrowbackhome(context),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                child: Form(
                  key: _formKey2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Fill the form to Charge Wallet :",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Segoe UI',
                              color: const Color(0xffffffff),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Credit Card Details :",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Segoe UI',
                            color: const Color(0xffffffff),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Amount of Money",
                          Icons.credit_card,
                          Amount,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Credit Card Number",
                          Icons.credit_card,
                          Credit_number,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "CVV Number",
                          Icons.credit_card_sharp,
                          Cvvnumber,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: CustomBoxDecoration.decorationStyle(
                              Color(0xd6a80f14), 15.0),
                          child: TextFormField(
                            controller: dateCtl,
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
                              dateCtl.text = date.toString().substring(0, 10);
                            },
                            onSaved: (val) {
                              this.expireDate = val;
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return " Expire Date couldn't be blank!";
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: CustomInputDecoration.textFieldStyle(
                              "Expire Date",
                              Icon(
                                Icons.calendar_today,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey2.currentState.validate()) {
                              _formKey2.currentState.save();
                              await ChargeWallett(context);
                              try {} catch (error) {}
                            } else {}
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 90.0),
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: CustomBoxDecoration.decorationStyle(
                                  Color(0xFFFFFFFF), 10.0),
                              child: Center(
                                child: Text(
                                  "Charge",
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
