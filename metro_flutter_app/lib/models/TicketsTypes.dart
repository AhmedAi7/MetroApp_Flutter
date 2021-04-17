import 'dart:core';
import 'package:flutter/material.dart';

class product {
  String stations, price;
  int id,limit;
  product({
    this.stations,
    this.price,
    this.id,
    this.limit
  });
}

List<product> productss = [
  product(stations: "9 Stations", price: "5 EGP", id: 1, limit: 9),
  product(stations: "16 Stations", price: "7 EGP", id: 2, limit: 16),
  product(stations: "36 Stations", price: "10 EGP", id: 3, limit: 36),
];
