import 'dart:core';
import 'package:flutter/material.dart';

class product
{
  String trips ,stations, months,price;
  int id;
  product(
      {
        this.trips,
        this.stations,
        this.months,
        this.price,
        this.id,

      }
      );
}
List<product> products=[
  product(
   trips: "120 Trip",
    stations: "9 Stations",
     months: "3 Months",
    price: "250 EGP",
    id :1

  ),
  product(
      trips: "120 Trip",
      stations: "16 Stations",
      months: "3 Months",
      price: "380 EGP",
      id :2

  ),
  product(
      trips: "120 Trip",
      stations: "36 Stations",
      months: "3 Months",
      price: "480 EGP",
      id :3
  ),

  product(
      trips: "120 Trip",
      stations: "9 Stations",
      months: "1 Months",
      price: "120 EGP",
      id :4
  )
];