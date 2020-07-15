import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/screens/auth.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/screens/main.dart';
import 'package:ziggeo_example/utils.dart';

import 'localization.dart';

void main() => runApp(ZiggeoDemoApp());

class ZiggeoDemoApp extends StatefulWidget {
  @override
  _ZiggeoDemoAppState createState() => _ZiggeoDemoAppState();
}

class _ZiggeoDemoAppState extends State<ZiggeoDemoApp> {

  Future<bool> isLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(Utils.keyAppToken).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: FutureBuilder(
          future: isLoggedIn(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return MainScreen();
            }
            return AuthScreen(); // noop, this builder is called again when the future completes
          },
        ),
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
      ),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<DrawerStateInfo>(
          create: (BuildContext context) => DrawerStateInfo(),
        ),
      ],
    );
  }
}
