import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:metro_flutter_app/view/confirm_password.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String oldPassword;
  String newPassword;
  String confirmNewPassword;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  bool lenghtFlag;
  bool upperFlag;
  bool lowerFlag;
  bool numberFlag;
  bool oldPasswordFlag;
  bool matchFlag;
  final _formKey = GlobalKey<FormState>();

  void _checkPasswordValidation() {
    if (oldPassword == user.password)
      setState(() {
        oldPasswordFlag = true;
      });
    else
      setState(() {
        oldPasswordFlag = false;
      });

    if ((newPassword.length >= 6 && newPassword.length <= 20) ||
        (confirmNewPassword.length >= 6 && confirmNewPassword.length <= 20))
      setState(() {
        lenghtFlag = true;
      });
    else
      setState(() {
        lenghtFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[A-Z]')) &&
        confirmNewPassword.contains(new RegExp(r'[A-Z]')))
      setState(() {
        upperFlag = true;
      });
    else
      setState(() {
        upperFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[a-z]')) &&
        confirmNewPassword.contains(new RegExp(r'[a-z]')))
      setState(() {
        lowerFlag = true;
      });
    else
      setState(() {
        lowerFlag = false;
      });

    if (newPassword.contains(new RegExp(r'[0-9]')) &&
        confirmNewPassword.contains(new RegExp(r'[0-9]')))
      setState(() {
        numberFlag = true;
      });
    else
      setState(() {
        numberFlag = false;
      });

    if (newPassword == confirmNewPassword)
      setState(() {
        matchFlag = true;
      });
    else
      setState(() {
        matchFlag = false;
      });
  }

  void _send() {
    if (oldPasswordFlag &&
        upperFlag &&
        lowerFlag &&
        numberFlag &&
        matchFlag &&
        lenghtFlag) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmPassword(
            newPassword: newPassword,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: CustomBoxDecoration.decorationStyle(
                            Color(0xd6a80f14), 15.0),
                        child: TextFormField(
                          obscureText: _obscureText3,
                          onSaved: (val) {
                            this.oldPassword = val;
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return "This Field couldn't be blank!";
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
                              fontSize: 11,
                            ),
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
                                _obscureText3
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText3 = !_obscureText3;
                                });
                              },
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                            labelText: " Current Password",
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
                          obscureText: _obscureText,
                          onSaved: (val) {
                            newPassword = val;
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return "This Field couldn't be blank!";
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
                              fontSize: 11,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xd6a80f14),
                              ),
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
                            labelText: " New Password",
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
                          obscureText: _obscureText2,
                          onSaved: (val) {
                            this.confirmNewPassword = val;
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return "This Field couldn't be blank!";
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
                                _obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFFE5E5E5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                            labelText: " Confirm New Password",
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
                            _checkPasswordValidation();
                            _send();
                            try {} catch (error) {}
                          }
                        },
                        child: InkWell(
                          child: Container(
                            width: 280,
                            height: 50,
                            decoration: CustomBoxDecoration.decorationStyle(
                              Color(0xFFFFFFFF),
                              10.0,
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
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password should :",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        if (lenghtFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (lenghtFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (lenghtFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contain at least 6-20 characters long.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (upperFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (upperFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (upperFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains an upper case letter.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (lowerFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (lowerFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (lowerFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains an lower case letter.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (numberFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (numberFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (numberFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Contains a number.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (matchFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (matchFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (matchFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Match Confirm Password.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (oldPasswordFlag == null)
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        if (oldPasswordFlag == true)
                          Icon(
                            Icons.check_circle,
                            color: Color(0xff1CA612),
                          ),
                        if (oldPasswordFlag == false)
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent[700],
                          ),
                        Text(
                          " Old Password should be correct.",
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
