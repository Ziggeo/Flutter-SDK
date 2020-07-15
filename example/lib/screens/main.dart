import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziggeo_example/routes.dart';
import 'package:ziggeo_example/screens/about.dart';
import 'package:ziggeo_example/screens/available_sdks.dart';
import 'package:ziggeo_example/screens/contact_us.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/screens/recordings/recordings.dart';
import 'package:ziggeo_example/screens/settings.dart';
import 'package:ziggeo_example/screens/top_clients.dart';
import 'package:ziggeo_example/screens/video_editor.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/recordings';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: SafeArea(child: getBodyBasedOnSelectedRoute()));
  }

  getBodyBasedOnSelectedRoute() {
    switch (
        Provider.of<DrawerStateInfo>(context, listen: false).selectedRoute) {
      case Routes.video_editor:
        return VideoEditorScreen();
      case Routes.settings:
        return SettingsScreen();
      case Routes.sdks:
        return AvailableSdksScreen();
      case Routes.clients:
        return TopClientsScreen();
      case Routes.contact:
        return ContactUsScreen();
      case Routes.about:
        return AboutScreen();
      case Routes.recordings:
      default:
        return RecordingsScreen();
    }
  }
}
