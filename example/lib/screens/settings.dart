import 'package:flutter/material.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'title_settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
