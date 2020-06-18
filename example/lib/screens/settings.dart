import 'package:flutter/material.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: TextLocalized('coming_soon'),
        alignment: Alignment.center,
      ),
    );
  }
}
