import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gui_commons.dart';

const CREDITS = [
  ["Game developed by ", "Fireslime Team", "https://fireslime.xyz"],
  ["Music composed by ", "Joshua McLean", "http://mrjoshuamclean.com/"],
  ["Audio effects from ", "Mrthenoronha", "https://freesound.org/people/Mrthenoronha/sounds/371922/"],
  ["Base graphic assets by ", "0x72", "https://0x72.itch.io/16x16-robot-tileset"],
];

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class CreditsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: LayoutBuilder(builder: (_, size) {
          return Stack(children: [
            Row(
              children: [
                Column(
                  children: [
                    pad(Text('cReDiTs', style: title), 20.0),
                    btn('Go back', () {
                      Navigator.of(context).pop();
                    }),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Column(
                  children: CREDITS
                      .map((credit) => Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: credit[0], style: black_medium_text),
                                  TextSpan(
                                    text: credit[1],
                                    style: medium_link,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _launchURL(credit[2]);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ]);
        }),
      ),
    );
  }
}