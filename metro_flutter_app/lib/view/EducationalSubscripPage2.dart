import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/Textfeildd.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'dart:io';
import 'package:metro_flutter_app/view/EducationalSubscripPage3.dart';

class EducationSubscription2 extends StatefulWidget {
  @override
  _EducationSubscription2State createState() => _EducationSubscription2State();
}

class _EducationSubscription2State extends State<EducationSubscription2> {
  String fullname;
  String email;
  String phonenumber;
  String nationalid;
  String country, city;
  // ignore: non_constant_identifier_names
  String Station1, Station2;
  // ignore: unused_field
  File _image1;
  // ignore: unused_field
  File _image2;
  // ignore: unused_field
  File _image;
  final picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _openImagePicker2() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image1 = File(pickedImage.path);
      });
    }
  }

  final _formKey3 = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(),
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
            arrowback(context),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                child: Form(
                  key: _formKey3,
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
                          "Fill the form to apply for\nEducational Subscription",
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
                          height: 10,
                        ),
                        textfield(
                          "National ID",
                          Icons.credit_card,
                          email,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenwidth / 2.34,
                          height: 55,
                          decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xd6a80f14),
                            15.0,
                          ),
                          child: TextFormField(
                            onTap: _openImagePicker,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: CustomInputDecoration.textFieldStyle(
                              "Upload National ID",
                              Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        textfield(
                          "Edu ID",
                          Icons.credit_card,
                          email,
                          55,
                          screenwidth,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenwidth / 2.34,
                          height: 55,
                          decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xd6a80f14),
                            15.0,
                          ),
                          child: TextFormField(
                            onTap: _openImagePicker2,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: CustomInputDecoration.textFieldStyle(
                              "Upload Edu Photo",
                              Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textfield(
                              "Station 1",
                              Icons.my_location,
                              Station1,
                              55,
                              screenwidth / 2.34,
                            ),
                            textfield(
                              "Station 2",
                              Icons.location_on_outlined,
                              Station2,
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
                          onTap: () {
                            if (_formKey3.currentState.validate()) {
                              _formKey3.currentState.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EducationSubscription3(),
                                ),
                              );
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
