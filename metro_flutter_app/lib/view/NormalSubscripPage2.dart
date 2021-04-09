import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';

class normalsup2 extends StatefulWidget {
  @override
  _normalsup2State createState() => _normalsup2State();
}

class _normalsup2State extends State<normalsup2> {
  @override
  String fullname;
  String email;
  String phonenumber;
  String nationalid;
  String country,city;
  String Station1,Station2;
  final _formKey1 = GlobalKey<FormState>();

  bool _obscureText = true;
  Widget build(BuildContext context) {
   double screenwidth=  MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MainDrawer(),
        appBar:buildAppBar(),
        body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
    child: Stack(
    children :[ Container(
    height: MediaQuery.of(context).size.height,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/Background.png"),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
    )),
      InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width:30 ,
              alignment:Alignment.topLeft,
              child: Icon(Icons.arrow_back,color: Colors.white,semanticLabel: "back",
              ),
            ),
          )
      ),
      Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Container(
          child: Form(
              key: _formKey1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fill the form to apply for\nNormal Subscription :",style:
                      TextStyle(
                          fontSize: 18,
                          fontFamily: 'Segoe UI',
                          color: const Color(0xffffffff),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2
                      ),textAlign: TextAlign.left,),
                  SizedBox(
                    height: 10,
                  ),
                  textfield("Fullname", Icons.perm_contact_cal_sharp, fullname, 55, screenwidth),
                  SizedBox(
                    height: 10,
                  ),
                  textfield("Email", Icons.email, email, 55, screenwidth),
                  SizedBox(
                    height: 10,
                  ),
                  textfield("Phone Number", Icons.phone, phonenumber, 55, screenwidth),
                  SizedBox(
                    height: 10,
                  ),
                  textfield("National ID", Icons.credit_card, email, 55, screenwidth),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textfield("Country", Icons.location_city, country, 55, screenwidth/2.34),
                      textfield("City", Icons.location_city, city, 55, screenwidth/2.34),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textfield("Station 1", Icons.my_location, Station1, 55, screenwidth/2.34),
                          textfield("Station 2", Icons.location_on_outlined, Station2, 55, screenwidth/2.34),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                  InkWell(
                    onTap: () {
                      if (_formKey1.currentState.validate()) {
                        _formKey1.currentState.save();
                        Navigator.popAndPushNamed(context, 'NavgPage');
                        try {} catch (error) {}
                      } else {}
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
                            "Next",
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
                ]),
              ))),
      )
    ])
    )
    );
  }
}
