import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:metro_flutter_app/view/SignUp3Page.dart';

class SignUp2Page extends StatelessWidget {
  String phoneNumber;

  String dateOfBirth;

  TextEditingController dateCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _sendDataToSecondScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp3Page(
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Background.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.dstIn),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("images/metro-logo.png"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Container(
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xd6a80f14), 15.0),
                        child: TextFormField(
                          onSaved: (val) {
                            this.phoneNumber = val;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return " Phone Number couldn't be blank!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: CustomInputDecoration.textFieldStyle(
                            " Phone Number",
                            Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14),
                          15.0,
                        ),
                        child: TextFormField(
                          controller: dateCtl,
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1921, 1, 1),
                                maxTime: DateTime(2121, 12, 31),
                                onConfirm: (date) {
                              final formattedStr =
                                  DateFormat.yMMMd().format(date);
                              dateCtl.text = formattedStr.toString();
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          onSaved: (val) {
                            this.dateOfBirth = val;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return " Date Of Birth couldn't be blank!";
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: CustomInputDecoration.textFieldStyle(
                            " Date Of Birth",
                            Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              _sendDataToSecondScreen(context);
                            } catch (error) {}
                          } else {}
                        },
                        child: Container(
                          width: 280,
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
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
