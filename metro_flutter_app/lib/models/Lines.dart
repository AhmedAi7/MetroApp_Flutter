import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/station.dart';
import 'package:metro_flutter_app/view/Station.dart';
class Linee {
  int id;
  List<String> stations;
  Linee({this.id, this.stations});
}

ExpansionTile Line(String linenum ,List<Widget> child) {
  return ExpansionTile(
      title: Text(
        'Stations',
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