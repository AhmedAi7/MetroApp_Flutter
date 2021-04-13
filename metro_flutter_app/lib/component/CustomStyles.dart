import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration textFieldStyle(name, Icon icon) {
    return InputDecoration(
      errorStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 11),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffa80f14)),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      fillColor: Color(0xFFFFFFFF),
      filled: true,
      suffixIcon: icon,
      labelStyle: TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: 17,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
      labelText: name,
    );
  }
}

class CustomBoxDecoration {
  static BoxDecoration decorationStyle(Color color1, size) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(size),
      color: Color(0xffa80f14),
      boxShadow: [
        BoxShadow(
          color: color1,
          offset: Offset(0, 2),
          spreadRadius: -2,
          blurRadius: 6,
        ),
      ],
    );
  }
}
const kTextCol=const Color(0xffa80f14);
const kTextLIGHCol=Colors.grey;
const kDefulpadding=20.0;
InkWell arrowback(context){
  return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.topLeft,
          child: Icon(Icons.arrow_back, color: Colors.white,
            semanticLabel: "back",
          ),
        ),
      )
  );
}
InkWell arrowbackhome(context){
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "HomePage");
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.topLeft,
          child: Icon(Icons.arrow_back, color: Colors.white,
            semanticLabel: "back",
          ),
        ),
      )
  );
}

