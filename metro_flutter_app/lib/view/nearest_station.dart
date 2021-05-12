import 'package:flutter/material.dart';
import '../models/place.dart';
import '../component/Appbar.dart';
import '../view/location_input.dart';

class NearestStation extends StatefulWidget {
  @override
  _NearestStationState createState() => _NearestStationState();
}

class _NearestStationState extends State<NearestStation> {
  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  // ignore: unused_field
  PlaceLocation _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/Background.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8),
                    BlendMode.dstIn,
                  ),
                ),
              ),
              child: Column(
                children: [
                  LocationInput(_selectPlace),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
