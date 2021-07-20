import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:metro_flutter_app/models/SubTypes.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:metro_flutter_app/view/SubscriptionPage.dart';

LoginRequestModel LoginRequestModelJson (String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String LoginRequestModelToJson (LoginRequestModel data)=> json.encode(data.toJson());

class LoginRequestModel
{

  String username;
  String password;

  LoginRequestModel(
      {
        this.username,
        this.password
      });

  factory LoginRequestModel.fromJson(Map<String,dynamic> json)=>
      LoginRequestModel(username: json["username"],password:json["password"]);

  Map<String,dynamic> toJson() =>{
    "username":username,
    "password":password

  };
  String get Username   =>   username;
  String get Password   =>   password   ;
}