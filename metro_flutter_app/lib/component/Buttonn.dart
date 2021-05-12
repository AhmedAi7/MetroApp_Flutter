import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container button1(String text, StatefulWidget page, BuildContext context,
    double fontsize, double highth, double width) {
  return Container(
    padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 0, bottom: 10.0),
    height: highth,
    width: width,
    // ignore: deprecated_member_use
    child: RaisedButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30.0,
        ),
      ),
      color: const Color(0xffa80f14),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontsize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          fontFamily: 'Segoe UI',
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Container button2(String text, Future g) {
  return Container(
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: const Color(0xffffffff),
      boxShadow: [
        BoxShadow(
          color: const Color(0xffa80f14),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    ),
    height: 55.0,
    width: 160.0,
    // ignore: deprecated_member_use
    child: RaisedButton(
      onPressed: () {
        // ignore: unnecessary_statements
        g;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Upload Profile Photo",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
              fontFamily: "OpenSans",
              color: const Color(0x59000000),
            ),
          ),
          Icon(
            Icons.add_a_photo,
          ),
        ],
      ),
    ),
  );
}
