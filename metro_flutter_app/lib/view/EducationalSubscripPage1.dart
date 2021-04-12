
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/Buttonn.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';

import 'EducationalSubscripPage2.dart';

class edusub1 extends StatefulWidget {
  @override
  _edusub1State createState() => _edusub1State();
}

class _edusub1State extends State<edusub1> {
  File _image;
  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if(pickedImage != null){
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  @override
  String fullname;
  String email;
  String phonenumber;
  String nationalid;
  String country, city;
  String Station1, Station2;
  final _formKey2 = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double screenwidth=  MediaQuery.of(context).size.width;
    return Scaffold(
        appBar:buildAppBar(),
        drawer: MainDrawer(),
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
        arrowback(context)
                  ,
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(
            child: Form(
                key: _formKey2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Fill the form to apply for\nEducational Subscription", style:
                  TextStyle(
                      fontSize: 18,
                      fontFamily: 'Segoe UI',
                      color: const Color(0xffffffff),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                  ), textAlign: TextAlign.left,),
                  SizedBox(
                    height: 10,
                  ),
                  textfield(
                      "Fullname", Icons.perm_contact_cal_sharp, fullname, 55,
                      screenwidth),
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
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textfield("Country", Icons.location_city, country, 55, screenwidth/2.34),
                      textfield("City", Icons.location_city, city, 55, screenwidth/2.34),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                      Container(
                        width: screenwidth/2.34,
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xd6a80f14), 15.0),
                        child: TextFormField(
                          onTap: _openImagePicker,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: CustomInputDecoration.textFieldStyle(
                              "Upload Profile Photo", Icon(Icons.add_a_photo)),
                        ),
                      ),
                      SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey2.currentState.validate()) {
                      _formKey2.currentState.save();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => edusub2()));
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
        )]
    )
    )
    );
  }
}

