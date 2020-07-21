import 'package:flutter/material.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class ContactUsScreen extends StatefulWidget {
  static const String routeName = '/contact-us';

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
    Utils.sendEmail('support@ziggeo.com');
  }

  onVisitSupportPressed() async {
    Utils.openUrl('https://support.ziggeo.com');
  }
}
