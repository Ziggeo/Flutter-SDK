import 'package:flutter/material.dart';

import '../localization.dart';

class TextLocalized extends StatelessWidget {
  final String _key;
  final TextAlign textAlign;
  final TextStyle style;

  TextLocalized(this._key, {this.textAlign, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.instance.text(_key),
      textAlign: textAlign,
      style: style,
    );
  }
}
