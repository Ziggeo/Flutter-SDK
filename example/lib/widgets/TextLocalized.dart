import 'package:flutter/material.dart';
import '../localization.dart';

class TextLocalized extends StatelessWidget {
  final String _key;

  TextLocalized(this._key);

  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.instance.text(_key));
  }
}
