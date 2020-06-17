import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

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
                    Html(
                      style: {
                        "body": Style(
                          fontSize: FontSize(message_text_size),
                        ),
                        "a": Style(
                          // Note that the underline can be omitted, since the new parser merges styles with the element's
                          // default style rather than replacing that style.
                          color: Color(primary),
                        ),
                      },
                      data: AppLocalizations.instance.text('about_text'),
                    ),
                  ],
                ))));
  }
}
