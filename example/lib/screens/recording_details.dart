import 'package:flutter/material.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class RecordingDetailsScreen extends StatefulWidget {
  static const String routeName = '/recording-details';
  final RecordingModel recordingModel;

  RecordingDetailsScreen(this.recordingModel);

  @override
  _RecordingDetailsState createState() =>
      _RecordingDetailsState(recordingModel);
}

class _RecordingDetailsState extends State<RecordingDetailsScreen> {
  final RecordingModel recordingModel;
  bool isInEditMode = false;
  AppLocalizations localize = AppLocalizations.instance;

  _RecordingDetailsState(this.recordingModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: isInEditMode
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isInEditMode = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
          title: TextLocalized('title_details'),
          actions: isInEditMode
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {},
                  )
                ]
              : <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        isInEditMode = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  )
                ],
        ),
        body: Padding(
            padding: EdgeInsets.all(common_margin),
            child: Column(
              children: <Widget>[
                TextFormField(
                  enabled: isInEditMode,
                  initialValue: recordingModel.key ?? recordingModel.token,
                  style: !isInEditMode ? TextStyle(color: Colors.grey) : null,
                  decoration: InputDecoration(
                      labelText: localize.text('hint_token_or_key')),
                ),
                TextFormField(
                  enabled: isInEditMode,
                  style: !isInEditMode ? TextStyle(color: Colors.grey) : null,
                  initialValue: recordingModel.title,
                  decoration:
                      InputDecoration(labelText: localize.text('hint_title')),
                ),
                TextFormField(
                  enabled: isInEditMode,
                  style: !isInEditMode ? TextStyle(color: Colors.grey) : null,
                  initialValue: recordingModel.description,
                  decoration: InputDecoration(
                      labelText: localize.text('hint_description')),
                )
              ],
            )));
  }
}
