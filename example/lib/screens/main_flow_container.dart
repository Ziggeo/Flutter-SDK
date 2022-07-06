import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class MainScreen extends StatefulWidget {
  final String appToken;
  Ziggeo ziggeo;

  MainScreen(this.appToken, this.ziggeo);

  @override
  _MainScreenState createState() => _MainScreenState(appToken, ziggeo);
}

class _MainScreenState extends State<MainScreen> {
  String appToken;
  Ziggeo ziggeo;

  _MainScreenState(this.appToken, this.ziggeo);

  @override
  Widget build(BuildContext context) {
    var drawerState = Provider.of<DrawerState>(context);
    if (drawerState.ziggeo?.appToken == null) {
      drawerState.ziggeo = this.ziggeo;
    }
    return Scaffold(
        drawer: AppDrawer(appToken, ziggeo),
        appBar: AppBar(
          title: TextLocalized(drawerState.selectedRouteName ?? ''),
        ),
        body: SafeArea(child: drawerState.selectedRoute ?? Container()));
  }
}
