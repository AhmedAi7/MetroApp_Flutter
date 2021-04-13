import 'package:flutter/foundation.dart';

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String dateOfBirth;

  User({
    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.dateOfBirth,
    @required this.password,
  });
}

User user = User(
    name: 'Muhammad Bakr',
    email: 'mbakr7757@gmail.com',
    phoneNumber: '01151825393',
    dateOfBirth: 'Jun 9, 1999',
    password: 'mb20170224');
