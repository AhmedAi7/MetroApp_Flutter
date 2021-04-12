import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';

class chargewallet extends StatefulWidget {
  @override
  _chargewalletState createState() => _chargewalletState();
}

class _chargewalletState extends State<chargewallet> {
  @override
  String Expiredate,Expireyear;
  TextEditingController dateCtl = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();
  String fullname;
  String email;
  String phonenumber;
  String nationalid;
  String country, city;
  String Station1, Station2;
  final _formKey2 = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: buildAppBar(),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
                children: [ Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/Background.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstIn)),
                    )),
                  arrowbackhome(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                        child: Form(
                            key: _formKey2,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Please Fill the form to Charge Wallet :",
                                        style:
                                        TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Segoe UI',
                                            color: const Color(0xffffffff),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2
                                        ), textAlign: TextAlign.left,),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      textfield(
                                          "Credit Card",
                                          Icons.arrow_drop_down, fullname,
                                          55,
                                          screenwidth),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      textfield("Credit Card Number", Icons.credit_card, email, 55,
                                          screenwidth),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      textfield("CVV Number", Icons.credit_card_sharp,
                                          phonenumber, 55, screenwidth),
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
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                                date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100),
                                                );
                                                dateCtl.text = date.toString().substring(0,10);
                                              },
                                              onSaved: (val) {
                                                this.Expiredate = val;
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
                                                  "Expire Date", Icon(Icons.calendar_today)),
                                            ),
                                          ),

                                      SizedBox(
                                        height: 25,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_formKey2.currentState.validate()) {
                                            _formKey2.currentState.save();
                                            Navigator.pushNamed(context, "HomePage");
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
                                      )
                                    ]
                                )
                            )
                        )
                    ),
                  )
                ]
            )
        )
    );
  }
}