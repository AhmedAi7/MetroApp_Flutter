import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:metro_flutter_app/component/CustomStyles.dart';
import 'package:metro_flutter_app/component/main_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseSubscription extends StatefulWidget {
  String id;
  UseSubscription(this.id);

  @override
  _UseSubscriptionState createState() => _UseSubscriptionState(id);
}

class _UseSubscriptionState extends State<UseSubscription> {
  String id;

  _UseSubscriptionState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("Use Subscription"),
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
              data: "Sub-" + id,
              version: QrVersions.auto,
              size: 320.0,
              backgroundColor: Colors.white,
            ),
          )
        ]));
  }
}
