import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo_example/screens/auth.dart';
import 'package:ziggeo_example/screens/main_flow_container.dart';
import 'package:ziggeo_example/utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkIsLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    var appToken = prefs.getString(Utils.keyAppToken);
    if (appToken?.isNotEmpty ?? false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
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
