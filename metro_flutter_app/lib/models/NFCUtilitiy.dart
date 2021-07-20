import 'package:flutter/foundation.dart';
//import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NFC{
  String source;
  int limit;
  String subscirptionLimits;
  String destination;
  final bool isSubscription;

  NFC({
    @required this.isSubscription,
    this.limit,
    this.subscirptionLimits,
});

  

}