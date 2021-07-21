import 'package:flutter/material.dart';
import 'package:metro_flutter_app/models/station.dart';

class StationList extends StatelessWidget {
  final List<Station> stations;

  StationList(this.stations);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 300,
      width: screenWidth * 0.8,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                if (stations[index].state == false)
                  Icon(
                    Icons.directions_train_sharp,
                    color: Color(0xffa80f14),
                    size: 50,
                  ),
                if (stations[index].state == true)
                  Icon(
                    Icons.swap_horiz,
                    color: Colors.black,
                    size: 50,
                  ),
                Column(
                  children: [
                    Text(
                      stations[index].stationName,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Segoe UI',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: stations.length,
      ),
    );
  }
}
