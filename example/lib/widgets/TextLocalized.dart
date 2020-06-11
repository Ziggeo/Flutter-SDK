import 'package:flutter/material.dart';
import '../localization.dart';

class TextLocalized extends StatelessWidget {
  final String _key;
  final TextAlign textAlign;

  TextLocalized(this._key, [this.textAlign]);

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.instance.text(_key), textAlign: textAlign);
  }
}
