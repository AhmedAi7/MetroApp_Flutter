import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/Ticket.dart';

class UseTicket extends StatefulWidget {
  @override
  _UseTicketState createState() => _UseTicketState();
}

class _UseTicketState extends State<UseTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Stack(
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
              )),
          arrowbackhome(context),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 320.0,
            ),
            child: Center(child: ic),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 50.0,
            ),
            child: Center(
              child: CircleAvatar(
                backgroundColor:
                    switchControl == true ? Color(0xffa80f14) : Colors.white,
                radius: 66.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: IconButton(
                      onPressed: () {
                        if (switchControl == false) {
                          setState(() {
                            switchControl = true;
                            ic = Icon(
                              Icons.wifi_outlined,
                              size: 150.0,
                              color: const Color(0xffa80f14),
                            );
                          });
                          print('Switch is ON');
                          // Put your code here which you want to execute on Switch ON event.
                        } else {
                          setState(() {
                            switchControl = false;
                            ic = null;
                          });
                          print('Switch is OFF');
                        }
                      },
                      icon: Icon(Icons.power_settings_new),
                      iconSize: 120.0,
                      color: switchControl == true
                          ? Colors.white
                          : Color(0xffa80f14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //card(ticket),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container card(ticket) {
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
            width: double.maxFinite,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Origin Station",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${ticket.getSource()}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Segoe UI'),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Price",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${ticket.getPrice()} ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffa80f14),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Destination Station",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${ticket.getDestination()}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe UI',
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Ticket Limit",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "${ticket.getLimit()} ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffa80f14),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool switchControl = false;
  var textHolder = 'Switch is OFF';
  Icon ic;
  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        ic = Icon(Icons.wifi_tethering_outlined,
            size: 100.0, color: const Color(0xffa80f14));
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.
    } else {
      setState(() {
        switchControl = false;
        ic = null;
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }
}
