import 'dart:core';

class Productt {
  String stations, price;
  int id, limit;
  Productt({this.stations, this.price, this.id, this.limit});
}

List<Productt> productss = [
  Productt(stations: "9 Stations", price: "5 EGP", id: 1, limit: 9),
  Productt(stations: "16 Stations", price: "7 EGP", id: 2, limit: 16),
  Productt(stations: "36 Stations", price: "10 EGP", id: 3, limit: 36),
];
