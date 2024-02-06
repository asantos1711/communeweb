import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MagicLink extends StatelessWidget {
  MagicLink(this.url);

  String url;

  _launchURLBrowser(String url) async {
    //const url = 'https://www.google.com/maps/dir//21.1109375,-86.8425279/@21.1108518,-86.9125808,12z';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Si quieres usar la linea FastEntry by Commune valida tus datos aprentado este boton:",
                textAlign: TextAlign.center,
              )),
          InkWell(
            onTap: () {
              _launchURLBrowser(url);
            },
            child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 120,
                child: Image.asset("assets/verify.png")),
          ),
        ],
      ),
    );
  }
}
