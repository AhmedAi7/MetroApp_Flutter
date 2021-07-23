import 'dart:core';

class Tickett {
  final int ticketID;
  int price;
  int maximum_trips;
  String source_station;

  Tickett(this.ticketID, this.price, this.maximum_trips, this.source_station);
}

List<List<Tickett>> ListType=[
  Tickets_five,
  Tickets_seven,
  Tickets_ten
];
List<Tickett> Tickets_five = [

  ];

List<Tickett> Tickets_seven = [

  ];

List<Tickett> Tickets_ten = [

];