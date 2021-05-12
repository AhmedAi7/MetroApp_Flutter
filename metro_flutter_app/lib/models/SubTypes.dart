import 'dart:core';

class Product {
  String trips, stations, months, price;
  int id;
  Product({
    this.trips,
    this.stations,
    this.months,
    this.price,
    this.id,
  });
}

List<Product> products = [
  Product(
      trips: "120 Trip",
      stations: "9 Stations",
      months: "3 Months",
      price: "250 EGP",
      id: 1),
  Product(
      trips: "120 Trip",
      stations: "16 Stations",
      months: "3 Months",
      price: "380 EGP",
      id: 2),
  Product(
      trips: "120 Trip",
      stations: "36 Stations",
      months: "3 Months",
      price: "480 EGP",
      id: 3),
  Product(
      trips: "120 Trip",
      stations: "9 Stations",
      months: "1 Months",
      price: "120 EGP",
      id: 4)
];
