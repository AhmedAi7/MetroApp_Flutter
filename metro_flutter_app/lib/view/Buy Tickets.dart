import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/models/TicketsTypes.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';

class buyticket extends StatefulWidget {
  @override
  _buyticketState createState() => _buyticketState();
}

class _buyticketState extends State<buyticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        drawer: MainDrawer(),
        body: Stack(children: [
          Container(
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
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "HomePage");
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 30,
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    semanticLabel: "back",
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 42.0),
            child: Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: GridView.builder(
                      itemCount: 3,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: .9,
                      ),
                      itemBuilder: (context, index) => Card(productss[index])),
                )),
          )
        ]));
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
              width: 135,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("images/ticket.png")),
                    Text(
                      "___________",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${product1.stations}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe UI'),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "${product1.price} ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ])),
          Container(
            padding:
                EdgeInsets.only(left: 0.0, top: 0.0, right: 0, bottom: 10.0),
            height: 50,
            width: 135,
            child: RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "HomePage"),
              //padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0))),
              color: const Color(0xffa80f14),
              child: Text("Buy",
                  style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Segoe UI',
                      letterSpacing: 1.5,
                      color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
