import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:photo_view/photo_view.dart';

class MetroMap extends StatefulWidget {
  @override
  _MetroMapState createState() => _MetroMapState();
}

class _MetroMapState extends State<MetroMap> {
  @override
  Widget build(BuildContext context) {
     return
       Scaffold(
         appBar: buildAppBar("Map"),
    drawer: MainDrawer(),
    body:Stack(
         children: [
     Container(
     height: MediaQuery.of(context).size.height,
    width: double.infinity,
    color: Colors.white,
     ),
    arrowbackhome(context),
           // PinchZoom(
           //   child: Image.network('https://placekitten.com/640/360'),
           //   resetDuration: const Duration(milliseconds: 100),
           //   maxScale: 2.5,
           //   onZoomStart: (){print('Start zooming');},
           //   onZoomEnd: (){print('Stop zooming');},
           // ),
    Container(
      color: Colors.white,
    child: PhotoView(
    imageProvider: AssetImage("images/cairo_metro_map.png"),
    )
    )
         ]
     )
       );
  }
}
