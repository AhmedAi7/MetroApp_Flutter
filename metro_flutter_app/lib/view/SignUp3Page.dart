import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';

class SignUp3Page extends StatefulWidget {
  final String phoneNumber;
  SignUp3Page({this.phoneNumber});

  @override
  _SignUp3PageState createState() => _SignUp3PageState();
}

class _SignUp3PageState extends State<SignUp3Page>
    with TickerProviderStateMixin {
  String otpText = "An 6-digit code has been sent to";
  String otpExpired = "The OTP will be expired in ";
  String actualCode = "123456";
  String inputCode;
  String digit_1;
  String digit_2;
  String digit_3;
  String digit_4;
  String digit_5;
  String digit_6;

  final _formKey = GlobalKey<FormState>();
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 6),
    );

    controller.reverse(from: 1);
  }

  void _resend() {
    // send code then
    controller.reverse(from: 1);
  }

  void _checkCode() {
    inputCode = digit_1 + digit_2 + digit_3 + digit_4 + digit_5 + digit_6;
    if (inputCode == actualCode) {
      Navigator.pushNamed(context, 'SignUp4');
    }
  }

  @override
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Verify Your Mobile Number",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      otpText,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.phoneNumber,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: Text(
                            "Change",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_1 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_2 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_3 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_4 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_5 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        height: 50,
                        width: 45,
                        child: TextFormField(
                          onSaved: (val) {
                            digit_6 = val;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          otpExpired,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return Text(
                              timerString,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[400]),
                        ),
                        InkWell(
                          onTap: () {
                            _resend();
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFE5E5E5),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _checkCode();
                      try {} catch (error) {}
                    }
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
