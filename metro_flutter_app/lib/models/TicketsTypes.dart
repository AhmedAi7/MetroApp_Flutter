import 'dart:core';

class Product {
  String stations, price;
  int id, limit;
  Product({this.stations, this.price, this.id, this.limit});
}

List<Product> productss = [
  Product(stations: "9 Stations", price: "5 EGP", id: 1, limit: 9),
  Product(stations: "16 Stations", price: "7 EGP", id: 2, limit: 16),
  Product(stations: "36 Stations", price: "10 EGP", id: 3, limit: 36),
];
