import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';

class SignUp3Page extends StatelessWidget {
  String otpText = "An 6-digit code has been sent to";
  String number = "01019956386";
  String otpExpired = "The OTP will be expired in ";
  String time = "5:59";

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
                    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Verify Your Mobile Number",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      otpText,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text(
                            number,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                                decorationColor: Color(0xd6a80f14),
                                decorationThickness: 3,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      height: 50,
                      width: 45,
                      child: TextField(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      otpExpired + time,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
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
                          },
                          child: Text(
                            '  Resend  ',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFE5E5E5),decoration: TextDecoration.underline,
                                decorationColor: Color(0xd6a80f14),
                                decorationThickness: 1),
                          ),
                        )
                      ],
                    )
                  ],
                ),

                InkWell(
                  onTap: () {
                    try {
                      Navigator.pushNamed(context, 'SignUp4');
                    } catch (error) {}
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
