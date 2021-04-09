import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/screens/splash.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'localization.dart';

void main() async {
  if (kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ZiggeoDemoApp());
}

class ZiggeoDemoApp extends StatefulWidget {
  @override
  _ZiggeoDemoAppState createState() => _ZiggeoDemoAppState();
}

class _ZiggeoDemoAppState extends State<ZiggeoDemoApp> {
  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.crash();
    return MultiProvider(
      child: MaterialApp(
        home: SplashScreen(),
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
          textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Quicksand'),
          primaryTextTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: 'Quicksand', bodyColor: Colors.white),
          accentTextTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: 'Quicksand', bodyColor: Colors.white),
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
        ChangeNotifierProvider<DrawerState>(
          create: (BuildContext context) => DrawerState(),
        ),
      ],
    );
  }
}
