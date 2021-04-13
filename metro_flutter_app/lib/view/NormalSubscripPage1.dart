import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/Buttonn.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/SubTypes.dart';

import 'NormalSubscripPage2.dart';

class normalsub1 extends StatefulWidget {
  @override
  _normalsub1State createState() => _normalsub1State();
}

class _normalsub1State extends State<normalsub1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
        drawer: MainDrawer(),
        body : Stack(
        children :[ Container(
    height: MediaQuery.of(context).size.height,
    width: double.infinity,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/Background.png"),
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
    Colors.black.withOpacity(0.8), BlendMode.dstIn)),
    ),
    ),
    arrowback(context),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:22.0 ,vertical:60),
        child: Container(
          alignment: Alignment.bottomCenter,
          child:
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child:
                GridView.builder(itemCount: 4, gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                  , crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: .9,
                ),
                    itemBuilder: (context, index) => Card(products[index])),
              )
          ),
      )
    ]
    ));
  }

  Container Card(products) {
    final product product1 = products;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Expanded(
          //child:
          Container(
            alignment: Alignment.bottomCenter,
              height: 135,
              width: 144,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:Radius.circular(16)),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${product1.trips} ", style: TextStyle(
                      fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI'
                    ),),
                    Text("${product1.stations}", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI'
                    ),),
                    Text("${product1.months} ", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe UI'
                    ),)
                    ,
                       Text("___________",style:
                        TextStyle(
                          fontSize: 16,
                          color: Colors.black
                        ),
                      ),
                    Text("${product1.price} ", style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),)
                  ]
              )
          ),
      Container(
        padding: EdgeInsets.only(left: 0.0,top: 0.0,right: 0,bottom: 10.0),
        height: 50,
        width: 144,
        child: RaisedButton(
          onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => normalsup2() )),
          //padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft:  Radius.circular(30.0))
          ),
          color: const Color(0xffa80f14)
          ,
          child: Text("Subscripe", style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: 'Segoe UI'
              ,
              letterSpacing: 1.5
              ,
              color: Colors.white)),),
      )
        ],
      ),
    );
  }
}
