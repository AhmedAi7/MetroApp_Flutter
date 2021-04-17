import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/Buttonn.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:metro_flutter_app/models/Ticket.dart';
import 'package:metro_flutter_app/models/TicketsTypes.dart';

class useticket extends StatefulWidget {

  @override
  _useticketState createState() => _useticketState();
}
class _useticketState extends State<useticket> {
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
                    image: AssetImage("images\Background.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstIn)),
              ),
            ),
             arrowbackhome(context),
             Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Card(ticket),
                 SizedBox(height: 25.0,),
               ],
             )
            ]
        ));
  }

  Container Card(ticket) {
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30)),

              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Origin Station",style:
                      TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      ),
                      SizedBox(height: 5.0,),

                      Text("${ticket.getSource()}", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe UI'
                      ),),
                      SizedBox(height: 25.0,),
                      Text("Price",style:
                      TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      ),
                      SizedBox(height: 5.0,),
                      Text("${ticket.getPrice()} ", style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffa80f14),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),)
                    ]
                      )
                   ,
                   
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Destination Station",style:
                      TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      ),
                      SizedBox(height: 5.0,),

                      Text("${ticket.getDestination()}", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Segoe UI'
                      ),),
                      SizedBox(height: 25.0,),
                      Text("Ticket Limit",style:
                      TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      ),
                      ),
                      SizedBox(height: 5.0,),
                      Text("${ticket.getLimit()} ", style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffa80f14),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),)
                    ]
                      )
                   ],
                                ),
              )
          )
        ],
      ),
    );
  }
}
