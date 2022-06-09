import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recordings/audio_recording_model.dart';
import 'package:ziggeo_example/screens/recordings/image_recording_model.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/screens/video_player.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class RecordingDetailsScreen extends StatefulWidget {
  static const String routeName = 'title_details';
  final RecordingModel recordingModel;
  final Ziggeo ziggeo;

  RecordingDetailsScreen(this.ziggeo, this.recordingModel);

  @override
  _RecordingDetailsState createState() =>
      _RecordingDetailsState(ziggeo, recordingModel);
}

class _RecordingDetailsState extends State<RecordingDetailsScreen> {
  final Ziggeo ziggeo;
  RecordingModel recordingModel;
  bool isInEditMode = false;
  bool isLoading = false;
  String? previewPath;
  AppLocalizations localize = AppLocalizations.instance;

  _RecordingDetailsState(this.ziggeo, this.recordingModel);

  @override
  void initState() {
    super.initState();
    fetchPreview();
  }

  fetchPreview() async {
    setState(() {
      isLoading = true;
    });
    if (recordingModel.type == RecordingModel.video_type) {
      await ziggeo.videos.getImageUrl(recordingModel.token).then((value) {
        setState(() {
          previewPath = value;
          isLoading = false;
        });
      }, onError: (error) => handleError(error));
    } else if (recordingModel.type == RecordingModel.image_type) {
      await ziggeo.images.getImageUrl(recordingModel.token).then((value) {
        setState(() {
          previewPath = value;
          isLoading = false;
        });
      }, onError: (error) => handleError(error));
    } else {
      setState(() {
        previewPath = null;
        isLoading = false;
      });
    }
  }

  onSavedBtnPressed() {
    setState(() {
      isLoading = true;
    });

    if (recordingModel.type == RecordingModel.video_type) {
      ziggeo.videos.update(recordingModel.toJson()).then((value) {
        setState(() {
          isLoading = false;
          recordingModel = RecordingModel.fromJson(
              json.decode(value ?? ''), recordingModel.type);
          isInEditMode = false;
        });
      }, onError: (error) => handleError(error));
    } else if (recordingModel.type == RecordingModel.audio_type) {
      var model = ImageRecordingModel.create(recordingModel);
      ziggeo.audios.update(model.toJson()).then((value) {
        setState(() {
          isLoading = false;
          recordingModel =
              RecordingModel.fromJson(json.decode(value), recordingModel.type);
          isInEditMode = false;
        });
      }, onError: (error) => handleError(error));
    } else if (recordingModel.type == RecordingModel.image_type) {
      var model = AudioRecordingModel.create(recordingModel);
      ziggeo.images.update(model.toJson()).then((value) {
        setState(() {
          isLoading = false;
          recordingModel =
              RecordingModel.fromJson(json.decode(value), recordingModel.type);
          isInEditMode = false;
        });
      }, onError: (error) => handleError(error));
    }
  }

  onDeleteBtnPressed() {
    setState(() {
      isLoading = true;
    });
    if (recordingModel.type == RecordingModel.video_type) {
      ziggeo.videos.destroy(recordingModel.token).then(
          (value) => Navigator.of(context).pop(),
          onError: (error) => handleError(error));
    } else if (recordingModel.type == RecordingModel.audio_type) {
      ziggeo.audios.destroy(recordingModel.token).then(
          (value) => Navigator.of(context).pop(),
          onError: (error) => handleError(error));
    } else if (recordingModel.type == RecordingModel.image_type) {
      ziggeo.images.destroy(recordingModel.token).then(
          (value) => Navigator.of(context).pop(),
          onError: (error) => handleError(error));
    }
  }

  onEditBtnPressed() {
    setState(() {
      isInEditMode = true;
    });
  }

  handleError(error) {
    print(error);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
          title: TextLocalized(RecordingDetailsScreen.routeName),
          actions: isInEditMode
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => onSavedBtnPressed(),
                  )
                ]
              : <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEditBtnPressed(),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onDeleteBtnPressed(),
                  )
                ],
        ),
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(common_margin),
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      previewPath != null
                          ? Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Image.network(
                                  previewPath!,
                                  height: preview_height,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Visibility(
                                    visible: recordingModel.type ==
                                        RecordingModel.image_type,
                                    child: IconButton(
                                      icon: Icon(Icons.zoom_in_sharp),
                                      onPressed: onPlayButtonPressed,
                                      iconSize: btn_play_size,
                                    )),
                                Visibility(
                                    visible: recordingModel.type ==
                                        RecordingModel.video_type,
                                    child: IconButton(
                                      onPressed: onPlayButtonPressed,
                                      icon: Icon(Icons.play_circle_filled),
                                      iconSize: btn_play_size,
                                      color: Color(accent),
                                    ))
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: onPlayButtonPressed,
                                  icon: Icon(Icons.mic),
                                  iconSize: btn_play_size,
                                )
                              ],
                            ),
                      TextFormField(
                        enabled: isInEditMode,
                        initialValue:
                            recordingModel.key ?? recordingModel.token,
                        style: !isInEditMode
                            ? TextStyle(color: Colors.grey)
                            : null,
                        decoration: InputDecoration(
                            labelText: localize.text('hint_token_or_key')),
                      ),
                      TextFormField(
                        onChanged: (value) => recordingModel.title = value,
                        enabled: isInEditMode,
                        style: !isInEditMode
                            ? TextStyle(color: Colors.grey)
                            : null,
                        initialValue: recordingModel.title,
                        decoration: InputDecoration(
                            labelText: localize.text('hint_title')),
                      ),
                      TextFormField(
                        onChanged: (value) =>
                            recordingModel.description = value,
                        enabled: isInEditMode,
                        style: !isInEditMode
                            ? TextStyle(color: Colors.grey)
                            : null,
                        initialValue: recordingModel.description,
                        decoration: InputDecoration(
                            labelText: localize.text('hint_description')),
                      )
                    ],
                  ))),
              if (isLoading)
                Container(
                  color: Color(progressIndicatorGrayFilter),
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ));
  }

  onPlayButtonPressed() async {
    if (recordingModel.type == RecordingModel.video_type) {
      await SharedPreferences.getInstance().then((value) {
        if (value.containsKey(Utils.keyCustomPlayerMode) &&
            (value.getBool(Utils.keyCustomPlayerMode) ?? false)) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  VideoPlayerScreen(ziggeo, recordingModel.token, null)));
        } else {
          ziggeo.startPlayerFromToken([recordingModel.token]);
        }
      });
    }
    if (recordingModel.type == RecordingModel.audio_type) {
      ziggeo.startAudioPlayerByToken(recordingModel.token);
    }
    if (recordingModel.type == RecordingModel.image_type) {
      ziggeo.showImageByToken(recordingModel.token);
    }
  }
}
