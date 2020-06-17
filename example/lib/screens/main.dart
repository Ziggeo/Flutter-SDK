import 'package:flutter/material.dart';
import 'package:ziggeo_example/screens/about.dart';
import 'package:ziggeo_example/screens/contact_us.dart';
import 'package:ziggeo_example/screens/drawer.dart';
import 'package:ziggeo_example/screens/recordings.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/recordings';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(),
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        body: SafeArea(child: getBodyBasedOnSelectedRoute()));
  }

  getBodyBasedOnSelectedRoute() {
//    switch (drawer.state.selectedRote) {
//      case Routes.recordings:
    return RecordingsScreen();
//      case Routes.video_editor:
//        return VideoEditorScreen();
//      case Routes.settings:
//        return SettingsScreen();
//      case Routes.sdks:
//        return AvailableSdksScreen();
//      case Routes.clients:
//        return TopClientsScreen();
//      case Routes.contact:
//        return ContactUsScreen();
//      case Routes.about:
//        return AboutScreen();
//    }
  }
}
