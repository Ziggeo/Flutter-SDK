import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/utils.dart';
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
  String previewPath;
  AppLocalizations localize = AppLocalizations.instance;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _RecordingDetailsState(this.recordingModel);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  Future<Null> fetchPreview() async {
    final prefs = await SharedPreferences.getInstance();
    await Ziggeo(prefs.getString(Utils.keyAppToken))
        .videos
        .getImageUrl(recordingModel.token)
        .then((value) {
      setState(() {
        previewPath = value;
      });
    }, onError: (error) {
      print(error);
    });

    return null;
  }

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
            child: RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: () => this.fetchPreview(),
                child: Column(
                  children: <Widget>[
                    previewPath != null
                        ? Image.network(
                            previewPath,
                            height: preview_height,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Color(primary),
                            height: preview_height,
                            width: double.infinity,
                          ),
                    TextFormField(
                      enabled: isInEditMode,
                      initialValue: recordingModel.key ?? recordingModel.token,
                      style:
                          !isInEditMode ? TextStyle(color: Colors.grey) : null,
                      decoration: InputDecoration(
                          labelText: localize.text('hint_token_or_key')),
                    ),
                    TextFormField(
                      enabled: isInEditMode,
                      style:
                          !isInEditMode ? TextStyle(color: Colors.grey) : null,
                      initialValue: recordingModel.title,
                      decoration: InputDecoration(
                          labelText: localize.text('hint_title')),
                    ),
                    TextFormField(
                      enabled: isInEditMode,
                      style:
                          !isInEditMode ? TextStyle(color: Colors.grey) : null,
                      initialValue: recordingModel.description,
                      decoration: InputDecoration(
                          labelText: localize.text('hint_description')),
                    )
                  ],
                ))));
  }
}
