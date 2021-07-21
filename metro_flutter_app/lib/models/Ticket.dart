import 'package:flutter/foundation.dart';
import 'TicketsTypes.dart';

class Ticket {
  final int ticketID;
  int price;
  int maximum_trips;
  String source_station;
  bool valid = false;
  String source="";
  String destination="";

  Ticket({
    @required this.ticketID,

  });

  String getSource(){
    if (source.isEmpty){
      return "Not Determined Yet";
    }
    else {
      return source;
    }
  }
  String getDestination(){
    if (source.isEmpty){
      return "Not Determined Yet";
    }
    else {
      return destination;
    }
  }
  // String getPrice(){
  //   for (int i=0 ; i< productss.length;i++){
  //     if (productss[i].id==basicID){
  //       return productss[i].price;
  //     }
  //   }
  //   return null;
  // }
  // String getLimit(){
  //   for (int i=0 ; i< productss.length;i++){
  //     if (productss[i].id==basicID){
  //       return productss[i].stations;
  //     }
  //   }
  //   return null;
  // }
}

// Ticket ticket = new Ticket(ticketID: 20170008, basicID: 1, hexaCode: "20170008114");