import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/view/confirm_phoneNumber.dart';

// ignore: must_be_immutable
class EditPhoneNumber extends StatelessWidget {
  String newPhoneNumber;
  final _formKey = GlobalKey<FormState>();

  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmPhoneNumber(
          newPhoneNumber: newPhoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(),
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
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _sendDataToSecondScreen(context);
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
