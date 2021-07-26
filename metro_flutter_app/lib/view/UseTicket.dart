import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseTicket extends StatefulWidget {
  int id;
  UseTicket(this.id);

  @override
  _UseTicketState createState() => _UseTicketState(id);
}

class _UseTicketState extends State<UseTicket> {
  int id;

  _UseTicketState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("Use Ticket"),
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
                    Colors.black.withOpacity(0.8),
                    BlendMode.dstIn,
                  ),
                ),
              )),
          arrowback(context),
          Center(
            child: QrImage(
              data: "Ticket-$id",
              version: QrVersions.auto,
              size: 320.0,
              backgroundColor: Colors.white,
            ),
          )
        ]));
  }
}
