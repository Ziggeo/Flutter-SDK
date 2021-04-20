import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/qr/qr_scanner_listener.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/main_flow_container.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../localization.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _enterQrManuallyMode = false;
  Ziggeo _ziggeo;
  String _inputToken;
  final _formKey = GlobalKey<FormState>();

  _AuthScreenState() {
    _ziggeo = Ziggeo(null);
    _ziggeo.qrScannerConfig = QrScannerConfig();
    _ziggeo.qrScannerConfig.eventsListener = QrScannerEventListener(
      onDecoded: (value) => {this.saveTokenAndNavigateToMainScreen(value)},
    );
  }

  onQrActionPressed() async {
    if (_enterQrManuallyMode) {
      if (_formKey.currentState.validate()) {
        saveTokenAndNavigateToMainScreen(_inputToken);
      }
    } else {
      _ziggeo.startQrScanner();
    }
  }

  switchQrScannerMode() {
    this.setState(() {
      _enterQrManuallyMode = !_enterQrManuallyMode;
    });
  }

  saveTokenAndNavigateToMainScreen(String token) {
    SharedPreferences.getInstance().then((prefs) => prefs
        .setString(Utils.keyAppToken, token)
        .then((success) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => MainScreen(token, Ziggeo(token))))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(common_margin),
          child: Form(
              key: _formKey,
              child: Center(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: logo_margin_top),
                  Image.asset(
                    'assets/img/logo.png',
                    width: logo_width,
                  ),
                  SizedBox(height: logo_margin_bottom),
                  TextLocalized(
                    'auth_message',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: auth_controls_margin_top),
                  SizedBox(
                    height: qr_input_height,
                    child: _enterQrManuallyMode
                        ? TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.instance
                                    .text('err_not_empty');
                              }
                              return null;
                            },
                            onChanged: (value) => this.setState(() {
                              _inputToken = value;
                            }),
                            decoration: InputDecoration(
                                labelText: AppLocalizations.instance
                                    .text('enter_manually_hint')),
                          )
                        : null,
                  ),
                  SizedBox(
                      width: btn_qr_width,
                      height: btn_qr_height,
                      child: RaisedButton(
                          onPressed: () => this.onQrActionPressed(),
                          child: TextLocalized(
                            _enterQrManuallyMode
                                ? 'btn_use_entered_text'
                                : 'btn_scan_qr_text',
                          ))),
                  FlatButton(
                      onPressed: () => this.switchQrScannerMode(),
                      child: TextLocalized(
                        _enterQrManuallyMode
                            ? 'use_scanner_text'
                            : 'enter_qr_manually_text',
                      )),
                ],
              ))),
        ));
  }
}
