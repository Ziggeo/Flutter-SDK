import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class ContactUsScreen extends StatelessWidget {
  static const String routeName = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(common_margin),
            child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  TextLocalized(
                    'contact_title',
                    style: TextStyle(
                        fontSize: subtitle_text_size,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: common_margin,
                  ),
                  TextLocalized(
                    'contact_message',
                    style: TextStyle(fontSize: message_text_size),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.only(right: common_half_margin),
                            child: RaisedButton(
                              onPressed: () => this.onContactUsPressed(),
                              child: TextLocalized('btn_contact_us'),
                            ))),
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.only(left: common_half_margin),
                            child: RaisedButton(
                              onPressed: () => this.onVisitSupportPressed(),
                              child: TextLocalized('btn_visit_support'),
                            )))
                  ],
                ),
              )
            ])));
  }

  onContactUsPressed() async {
    final Email email = Email(
      recipients: ['support@ziggeo.com'],
    );

    await FlutterEmailSender.send(email);
  }

  onVisitSupportPressed() async {
    const url = 'https://support.ziggeo.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
