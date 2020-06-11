import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

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

  onQrActionPressed() {
    if (_enterQrManuallyMode) {
    } else {}
    Fluttertoast.showToast(msg: "onScanQrPressed");
  }

  switchQrScannerMode() {
    this.setState(() {
      _enterQrManuallyMode = !_enterQrManuallyMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(common_margin),
      child: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: logo_margin_top),
          Image.asset(
            'assets/img/logo.png',
            width: logo_width,
          ),
          SizedBox(height: logo_margin_bottom),
          TextLocalized('auth_message', TextAlign.center),
          SizedBox(height: auth_controls_margin_top),
          SizedBox(
            height: qr_input_height,
            child: _enterQrManuallyMode
                ? TextField(
                    decoration: InputDecoration(labelText: 'Full name'),
                  )
                : null,
          ),
          SizedBox(height: common_margin),
          SizedBox(
              width: btn_qr_width,
              child: RaisedButton(
                  onPressed: () => this.onQrActionPressed(),
                  child: TextLocalized(
                    _enterQrManuallyMode
                        ? 'btn_use_entered_text'
                        : 'btn_scan_qr_text',
                  ))),
          SizedBox(
              width: btn_qr_width,
              child: FlatButton(
                  onPressed: () => this.switchQrScannerMode(),
                  child: TextLocalized(
                    _enterQrManuallyMode
                        ? 'use_scanner_text'
                        : 'enter_qr_manually_text',
                  ))),
        ],
      )),
    ));
  }
}
