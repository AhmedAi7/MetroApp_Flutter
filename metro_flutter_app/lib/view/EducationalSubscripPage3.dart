import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/Buttonn.dart';

import 'NavgPage.dart';

class edusub3 extends StatefulWidget {
  @override
  _edusub3State createState() => _edusub3State();
}

class _edusub3State extends State<edusub3> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: buildAppBar(),
    body: SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Stack(
    children :[ Container(
    height: MediaQuery.of(context).size.height,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/Background.png"),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
    )),
    Padding(
      padding: const EdgeInsets.only(top: 140),
      child: Container(
        child :Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("An Email sent to your college\nPlease contact your students affairs\nto Complete the subscription",style:
                TextStyle(
                    fontSize: 16,
                    fontFamily: 'Segoe UI',
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                ),),
            ),
            SizedBox(height: 20.0,),
            Button1("Done", navScreen(), context, 18, 80, 170)
          ],
        ),
        ),
    ),
    ]
    )
    )
    );
  }
}
