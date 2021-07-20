// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:metro_flutter_app/component/Buttonn.dart';
// import 'package:metro_flutter_app/view/EducationalSubscripPage1.dart';
// import 'package:metro_flutter_app/view/NormalSubscripPage1.dart';
//
// class Subscription extends StatefulWidget {
//   @override
//   _SubscriptionState createState() => _SubscriptionState();
// }
//
// class _SubscriptionState extends State<Subscription> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/Background.png"),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.8),
//                   BlendMode.dstIn,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 30, left: 35),
//             child: Text(
//               "You dont have subscription\nPlease choose one:",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontFamily: 'Segoe UI',
//                 color: const Color(0xffffffff),
//                 fontStyle: FontStyle.italic,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//               ),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 button1(
//                   "Apply for Normal\n   Subscription",
//                   NormalSubscription1(),
//                   context,
//                   18,
//                   190,
//                   205,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 0.0, top: 10.0, right: 0, bottom: 10.0),
//                   height: 190,
//                   width: 205,
//                   // ignore: deprecated_member_use
//                   child: RaisedButton(
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EducationSubscription1(),
//                       ),
//                     ),
//                     padding: EdgeInsets.all(0.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     color: const Color(0xffa80f14),
//                     child: Text(
//                       "Apply for Educational\n      Subscription",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontStyle: FontStyle.italic,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Segoe UI',
//                         letterSpacing: 1.5,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
