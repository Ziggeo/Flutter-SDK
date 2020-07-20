import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/recordings';

  final String appToken;

  MainScreen(this.appToken);

  @override
  _MainScreenState createState() => _MainScreenState(appToken);
}

class _MainScreenState extends State<MainScreen> {
  String appToken;

  _MainScreenState(this.appToken);

  @override
  Widget build(BuildContext context) {
    var drawerState = Provider.of<DrawerState>(context);
    return Scaffold(
        drawer: AppDrawer(appToken),
        appBar: AppBar(
          title: TextLocalized(drawerState.selectedRouteTitle),
        ),
        body: SafeArea(child: drawerState.selectedRoute));
  }
}
