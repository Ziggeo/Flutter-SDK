import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';
import '../res/dimens.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _enterQrManuallyMode = false;

  @override
  void initState() {
    super.initState();
  }

  onScanQrPressed() {
    Fluttertoast.showToast(msg: "onScanQrPressed");
  }

  switchQrScannerMode() {
    this.setState(() {
      _enterQrManuallyMode = !_enterQrManuallyMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: <Widget>[
            Image.asset('assets/img/logo.png'),
            TextLocalized('auth_message'),
            RaisedButton(
                onPressed: () => this.onScanQrPressed(),
                child: TextLocalized(
                  _enterQrManuallyMode
                      ? 'btn_use_entered_text'
                      : 'btn_scan_qr_text',
                )),
            FlatButton(
                onPressed: () => this.switchQrScannerMode(),
                child: TextLocalized(
                  _enterQrManuallyMode
                      ? 'use_scanner_text'
                      : 'enter_qr_manually_text',
                )),
          ],
        )),
      ),
    );
  }
}
