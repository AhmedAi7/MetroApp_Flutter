import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';

class SignUp2Page extends StatelessWidget {
  int phoneNumber;

  String dateOfBirth;

  TextEditingController dateCtl = TextEditingController();
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
                    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
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
                            this.phoneNumber = int.parse(val);
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
                              " Phone Number", Icon(Icons.phone)),
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
                              " Date Of Birth", Icon(Icons.calendar_today)),
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
                              Navigator.pushNamed(context,'SignUp3');
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
