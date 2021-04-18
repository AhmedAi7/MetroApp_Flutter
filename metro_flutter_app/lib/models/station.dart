import 'package:flutter/foundation.dart';

class Station {
  String stationName;
  bool state;
  String direction;

  Station({
    @required this.stationName,
    @required this.state,
    this.direction,
  });
}
