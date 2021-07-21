import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:metro_flutter_app/models/Ticket.dart';

class User {
  String fullname;
  String email;
  String phoneNumber;
  String password;
  String dateOfBirth;
  double balance;
 // Set tickets=new HashSet<Ticket>();

  User({
    @required this.fullname,
    @required this.email,
    @required this.phoneNumber,
    @required this.dateOfBirth,
    @required this.password,
  });
}


User user =User(
  fullname: 'Muhammad Bakr',
  email: 'mbakr7757@gmail.com',
  phoneNumber: '01151825393',
  dateOfBirth: 'Jun 9, 1999',
  password: 'mb20170224',);

void changeUserName(String name) {
  user.fullname = name;
}

void changeDateOfBirth(String dateOfBirth) {
  user.dateOfBirth = dateOfBirth;
}

void changePassword(String password) {
  user.password = password;
}

void changePhoneNumber(String phoneNumber) {
  user.phoneNumber = phoneNumber;
}

void changeEmail(String email) {
  user.email = email;
}
