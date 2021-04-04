
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
    return Scaffold(
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
        Container(
          child: Form(
              key: _formKey2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
                    250),
                SizedBox(
                  height: 10,
                ),
                textfield("Email", Icons.email, email, 55, 250),
                SizedBox(
                  height: 10,
                ),
                textfield("Phone Number", Icons.phone, phonenumber, 55, 250),
                SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textfield("Country", Icons.location_city, country, 55, 160),
                    textfield("City", Icons.location_city, city, 55, 160),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                  //_image=null,
                  //Button2("Upload Profile picture", _openImagePicker()),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffa80f14),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  height: 55.0,
                  width: 175.0,
                  child:

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent
                      ,
                      shadowColor: Colors.transparent
                    ),
                      onPressed: _openImagePicker,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Upload Profile Photo",
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w300,
                              fontFamily: "OpenSans"
                              ,
                              color: const Color(0x59000000)),
                        ),
                        Icon(Icons.add_a_photo,color: Colors.grey ,)
                      ],
                    )
                    )
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
        )))]
    )
    )
    );
  }
}

