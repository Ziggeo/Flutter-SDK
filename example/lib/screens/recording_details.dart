import 'package:flutter/material.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class RecordingDetailsScreen extends StatelessWidget {
  static const String routeName = '/recording-details';
  final RecordingModel recordingModel;

  RecordingDetailsScreen(this.recordingModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextLocalized('title_details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(common_margin),
            child: Column(
              children: <Widget>[
                TextFormField(
                  enabled: false,
                  initialValue: recordingModel.key ?? recordingModel.token,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.instance.text('hint_token_or_key')),
                ),
                TextFormField(
                  enabled: false,
                  initialValue: recordingModel.title,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.instance.text('hint_title')),
                ),
                TextFormField(
                  enabled: false,
                  initialValue: recordingModel.description,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.instance.text('hint_description')),
                )
              ],
            )));
  }
}
