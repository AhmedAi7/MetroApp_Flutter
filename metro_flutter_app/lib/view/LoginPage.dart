import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  String email;

  String password;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                      height: 15,
                    ),
                    Container(
                      decoration: CustomBoxDecoration.decorationStyle(
                          Color(0xd6a80f14), 15.0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        onSaved: (val) {
                          this.password = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Password couldn't be blank!";
                          } else if (val.length < 6) {
                            return "Password can't be less than 6 letters!";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xd6a80f14)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelStyle: TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          labelText: " Password",
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
                          try {} catch (error) {}
                        } else {}
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xFFFFFFFF), 10.0),
                        child: Center(
                          child: Text(
                            "Login",
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
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFE5E5E5)),
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
                        '    Or Login With    ',
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
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFE5E5E5)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'SignUp1');
                    },
                    child: Text(
                      '  Sign Up  ',
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
