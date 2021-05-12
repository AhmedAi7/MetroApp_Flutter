import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'CustomStyles.dart';

Container textfield(
    String name, IconData icon, String input, double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: CustomBoxDecoration.decorationStyle(
      Color(0xd6a80f14),
      15.0,
    ),
    child: TextFormField(
      onSaved: (val) {
        input = val;
      },
      validator: (val) {
        if (val.isEmpty) {
          return "This Field couldn't be blank!";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: CustomInputDecoration.textFieldStyle(
        name,
        Icon(
          icon,
        ),
      ),
    ),
  );
}
