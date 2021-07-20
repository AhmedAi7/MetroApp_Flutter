import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:metro_flutter_app/models/SubTypes.dart';
import 'package:metro_flutter_app/models/user.dart';
import 'package:metro_flutter_app/view/SubscriptionPage.dart';
NormalSubscriptionmodel todoModelJson (String str) =>
    NormalSubscriptionmodel.fromJson(json.decode(str));
String todoModelToJson (NormalSubscriptionmodel data)=> json.encode(data.toJson());
class NormalSubscriptionmodel
{

  int id;
  User user;
  String full_name;
  String email;
  String phone;
  String national_id;
  String country;
  String city;
  String source;
  String target;
  Product subscription;


  NormalSubscriptionmodel(
      {
      this.id,
      this.user,
      this.full_name,
      this.email,
      this.phone,
      this.national_id,
      this.country,
      this.city,
      this.source,
      this.target,
      this.subscription,
});

  factory NormalSubscriptionmodel.fromJson(Map<dynamic,dynamic> json)=>
      NormalSubscriptionmodel(id: json["id"],user:json["user"],full_name:json["full_name"],email:json["email"],
        phone: json["phone"],national_id:json["national_id"],country:json["country"],city:json["city"],
        source: json["source"],target:json["target"],
       subscription:json["subscription"]);

  Map<dynamic,dynamic> toJson() =>{
    "id":id,
    "user":user  ,
    "full_name" :full_name ,
    "email":email  ,
    "phone": phone  ,
    "national_id" :national_id  ,
    "country" :country ,
    "city" :city  ,
    "source" : source ,
    "target":target  ,
    "subscription":subscription  ,
  };
  User get Userr   =>   user;
  String get Full_name   =>   full_name   ;
  String get Email   =>   email   ;
  String get Phone   =>    phone   ;
  String get National_id   =>   national_id   ;
  String get Country   =>   country   ;
  String get  City   =>   city   ;
  String get  Source   =>    source   ;
  String get Target   =>   target   ;
  Product get Subscriptionn   =>   subscription   ;
}