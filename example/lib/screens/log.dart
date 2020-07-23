import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/logger.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class LogScreen extends StatefulWidget {
  static const String routeName = 'title_log';

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<LogModel> logs = List();

  @override
  void initState() {
    super.initState();
    logs.addAll(Logger.buffer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(common_margin),
      child: Stack(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: logs.isEmpty
                  ? Container(
                      margin:
                          EdgeInsets.only(top: list_empty_message_margin_top),
                      child: TextLocalized('message_log_empty'))
                  : Container(
                      child: ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) => getListItem(index),
                    ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () => this.onSendReportBtnPressed(),
              child: TextLocalized('btn_send_report'),
            ),
          )
        ],
      ),
    ));
  }

  onSendReportBtnPressed() {}

  Widget getListItem(index) {
    return Text(logs[index].name);
  }
}
