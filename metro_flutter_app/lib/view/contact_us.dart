import 'package:flutter/material.dart';
import 'package:metro_flutter_app/component/Appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String phone = "201221116048";

    Future<void> _launchWhatsApp() async {
      try {
        bool launched =
            await launch("whatsapp://send?phone=$phone", forceSafariVC: false);

        if (!launched) {
          await launch("https://api.whatsapp.com/send/?phone=$phone",
              forceSafariVC: false);
        }
      } catch (e) {
        await launch("https://api.whatsapp.com/send/?phone=$phone",
            forceSafariVC: false);
      }
    }

    Future<void> _launchFacebook() async {
      try {
        bool launched =
            await launch("fb://page/160235924030378", forceSafariVC: false);

        if (!launched) {
          await launch("https://www.facebook.com/CairoMetropage/",
              forceSafariVC: false);
        }
      } catch (e) {
        await launch("https://www.facebook.com/CairoMetropage/",
            forceSafariVC: false);
      }
    }

    return Scaffold(
      appBar: buildAppBar("Contact Us"),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffD3D3D3),
          ),
          padding: EdgeInsets.only(top: 25),
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Column(
              children: [
                Text(
                  'Thank you for using our application. We hope that our app, with the services it provides, may impress you .... Communication we seek and are happy with it in order to provide you with a better service.',
                  style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 1.0,
                  width: screenWidth * 0.7,
                  color: Color(0xffa80f14),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Color(0xffa80f14),
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '(202) 25748353',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.contact_phone_rounded,
                      color: Color(0xffa80f14),
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '16048',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email_rounded,
                      color: Color(0xffa80f14),
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'contact.us@cairometro.gov.eg',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      'Social Media: ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xffa80f14),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: ImageIcon(
                          AssetImage('images/facebook-icon.png'),
                          color: Colors.blue[700],
                        ),
                      ),
                      onTap: _launchFacebook,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: ImageIcon(
                          AssetImage('images/whatsapp-icon.png'),
                          color: Colors.green,
                        ),
                      ),
                      onTap: _launchWhatsApp,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
