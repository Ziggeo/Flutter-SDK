import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo_example/screens/auth.dart';
import 'package:ziggeo_example/screens/main.dart';
import 'package:ziggeo_example/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkIsLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Utils.keyAppToken).isNotEmpty) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
