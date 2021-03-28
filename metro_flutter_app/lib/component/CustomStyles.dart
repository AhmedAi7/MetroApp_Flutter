import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration textFieldStyle(name,Icon icon) {
    return InputDecoration(
      errorStyle: TextStyle(color: Color(0xFFFFFFFF),fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 11),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xd6a80f14)),
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
  static BoxDecoration decorationStyle(Color color1,size) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(size),
      color: Color(0xd6a80f14),
      boxShadow: [
        BoxShadow(
          color: color1,
          offset: Offset(0, 2),
          spreadRadius: 0.1,
          blurRadius: 6,
        ),
      ],
    );
  }
}
