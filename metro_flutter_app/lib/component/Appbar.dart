import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: const Color(0xffa80f14),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "User221",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        )
      ],
    ),
  );
}
