import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:metro_flutter_app/view/Station.dart';
class Linee {
  int id;
  List<Stationn> stations;

  Linee({this.id, this.stations});

  factory Linee.fromJson(Map<dynamic, dynamic> json) {
    return Linee(
        id : json['columnId'],
        stations: json['columnTime']
    );
  }
}

ExpansionTile Line(String linenum ,List<Widget> child) {
  return ExpansionTile(
      title: Text(
        'Line '+linenum,
        style: TextStyle(
          color: Color(0xffa80f14).withOpacity(0.8),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      children: child
  );
}