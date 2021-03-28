import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';

class SignUp1Page extends StatelessWidget {

  String email;

  String name;

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
                          this.name = val;
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
                            " Full Name", Icon(Icons.perm_identity)),
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
                          this.email = val;
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
                            " Email", Icon(Icons.email)),
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
                            Navigator.pushNamed(context, 'SignUp2');
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(children: [
                      Expanded(
                          child: Divider(color: Color(0xFFE5E5E5), thickness: 1)),
                      Text(
                        '    Or Sign Up With    ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFE5E5E5)),
                      ),
                      Expanded(
                          child: Divider(color: Color(0xFFE5E5E5), thickness: 1)),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset("images/facebook-logo.png")),
                      InkWell(
                          onTap: () {},
                          child: Image.asset("images/google-logo.png")),
                    ],
                  ),
                ],
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
                        color: Color(0xFFE5E5E5)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context,'Login');
                      },
                    child: Text(
                      '  Login  ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFE5E5E5)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

