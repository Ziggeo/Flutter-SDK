import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
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
      body: Container(
        padding: EdgeInsets.all(common_margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextLocalized(
              'about_subtitle',
              style: TextStyle(
                  fontSize: subtitle_text_size, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: common_margin),
            Expanded(
              child: Html(
                data: AppLocalizations.instance.text('about_text'),
                onLinkTap: (url, _, __, ___) => onVisitUrlPressed(url),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onVisitUrlPressed(String? url) async {
    Utils.openUrl(url ?? '');
  }
}
