import 'package:flutter/material.dart';
import 'package:flutter_native_html_view/flutter_native_html_view.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = 'title_about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(common_margin),
                child: Column(
                  children: <Widget>[
                    TextLocalized(
                      'about_subtitle',
                      style: TextStyle(
                          fontSize: subtitle_text_size,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: common_margin),
                    FlutterNativeHtmlView(
                      htmlData: AppLocalizations.instance.text('about_text'),
                    ),
                  ],
                ))));
  }
}
