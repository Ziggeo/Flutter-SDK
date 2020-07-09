import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/screens/auth.dart';
import 'package:ziggeo_example/screens/main.dart';

import 'localization.dart';

void main() => runApp(ZiggeoDemoApp());

class ZiggeoDemoApp extends StatefulWidget {
  @override
  _ZiggeoDemoAppState createState() => _ZiggeoDemoAppState();
}

class _ZiggeoDemoAppState extends State<ZiggeoDemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
      ],
      theme: ThemeData.light().copyWith(
        primaryColor: Color(primary),
        primaryColorDark: Color(primaryDark),
        accentColor: Color(accent),
        primaryColorLight: Color(primaryLight),
        colorScheme: ColorScheme.light(
          primary: Color(primaryText),
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Color(primary), textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}
