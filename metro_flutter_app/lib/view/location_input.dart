import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'map_screen.dart';
import '../helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class LocationInput extends StatefulWidget {
  String _nearestStation = "Al-Sayeda Zainab";
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  bool flag = false;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      // ignore: unused_local_variable
      final locData = await Location().getLocation().then((value) {
        _showPreview(value.latitude, value.longitude);
        widget.onSelectPlace(value.latitude, value.longitude);
        setState(() {
          flag = true;
        });
      });
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (cxt) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    setState(() {
      flag = true;
    });
    // selectedLocation has longitude and latitude of the location which the user had selected
    //print(selectedLocation.latitude);
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            height: (screenHight -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).viewPadding.top -
                    MediaQuery.of(context).viewPadding.bottom -
                    kBottomNavigationBarHeight) *
                0.3,
            width: screenWidth * 0.88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFCDCDCD),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffa80f14),
                  offset: Offset(0, 1),
                  spreadRadius: 0.1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: _previewImageUrl == null
                ? Text(
                    'No Loaction is Selected',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.location_on),
                label: Text(
                  'Current Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.white,
                onPressed: _getCurrentLocation,
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textColor: Colors.white,
                onPressed: _selectOnMap,
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          if (flag)
            Column(
              children: [
                Container(
                  height: 50,
                  width: screenWidth * 0.88,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/walk.png"),
                      alignment: Alignment.centerRight,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffa80f14),
                        offset: Offset(0, 1),
                        spreadRadius: 0.1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  Nearest Station: ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffa80f14),
                        ),
                      ),
                      Text(
                        '  ' + widget._nearestStation,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'GetRoute');
                  },
                  child: Container(
                    width: screenWidth * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffa80f14),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 1),
                          spreadRadius: -2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Get Route",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'BuyTickets');
                  },
                  child: Container(
                    width: screenWidth * 0.5,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffa80f14),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0, 1),
                          spreadRadius: -2,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Buy Ticket",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
