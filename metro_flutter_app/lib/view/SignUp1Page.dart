import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/view/SignUp4Page.dart';

class SignUp1Page extends StatefulWidget {
  @override
  _SignUp1PageState createState() => _SignUp1PageState();
}

class _SignUp1PageState extends State<SignUp1Page> {
  String email;

  String name;

  String phoneNumber;

  String dateOfBirth;

  String username;

  TextEditingController dateCtl = TextEditingController();


  void _getDateOfBirth(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1921, 1, 1),
        maxTime: DateTime(2121, 12, 31), onConfirm: (date) {
          final formattedStr = DateFormat.yMMMd().format(date);
          setState(() {
            dateOfBirth = formattedStr.toString();
          });
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  bool _checkDate() {
    return (dateOfBirth == null) ? false : true;
  }

  final _formKey = GlobalKey<FormState>();

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
                Colors.black.withOpacity(0.8),
                BlendMode.dstIn,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          setState(() {
                            this.username = val;
                          });

                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "UserName couldn't be blank!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: CustomInputDecoration.textFieldStyle(
                          " User Name",
                          Icon(
                            Icons.perm_identity,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14), 15.0),
                      child: TextFormField(
                        onSaved: (val) {
                          setState(() {
                            this.name = val;
                          });

                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Name couldn't be blank!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: CustomInputDecoration.textFieldStyle(
                          " Full Name",
                          Icon(
                            Icons.perm_identity,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14), 15.0),
                      child: TextFormField(
                        onSaved: (val) {
                          setState(() {
                            this.email = val;
                          });

                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Email couldn't be blank!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: CustomInputDecoration.textFieldStyle(
                          " Email",
                          Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
          Container(
            decoration: CustomBoxDecoration.decorationStyle(
                Color(0xd6a80f14), 15.0),
            child: TextFormField(
              onSaved: (val) {
                setState(() {
                  this.phoneNumber = val;
                });

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
                          setState(() {
                            this.dateOfBirth = val;
                          });

                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return " Date of Birth couldn't be blank!";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: CustomInputDecoration.textFieldStyle(
                          "Date of Birth",
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
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          try {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SignUp4Page(username,name,email,phoneNumber,dateCtl.text),
                                )
                             );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFE5E5E5),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'Login');
                    },
                    child: Text(
                      '  Login  ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
