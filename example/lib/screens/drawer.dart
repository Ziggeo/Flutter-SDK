import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/routes.dart';
import 'package:ziggeo_example/screens/about.dart';
import 'package:ziggeo_example/screens/available_sdks.dart';
import 'package:ziggeo_example/screens/contact_us.dart';
import 'package:ziggeo_example/screens/recordings/recordings.dart';
import 'package:ziggeo_example/screens/settings.dart';
import 'package:ziggeo_example/screens/top_clients.dart';
import 'package:ziggeo_example/screens/video_editor.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    var drawerState = Provider.of<DrawerState>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              text: 'item_recordings',
              onTap: () => {selectRoute(drawerState, Routes.recordings)}),
          _createDrawerItem(
              text: 'item_video_editor',
              onTap: () => {selectRoute(drawerState, Routes.video_editor)}),
          _createDrawerItem(
              text: 'item_settings',
              onTap: () => {selectRoute(drawerState, Routes.settings)}),
          Divider(),
          _createDrawerItem(
              text: 'item_sdks',
              onTap: () => {selectRoute(drawerState, Routes.sdks)}),
          _createDrawerItem(
              text: 'item_clients',
              onTap: () => {selectRoute(drawerState, Routes.clients)}),
          _createDrawerItem(
              text: 'item_contact',
              onTap: () => {selectRoute(drawerState, Routes.contact)}),
          _createDrawerItem(
              text: 'item_about',
              onTap: () => {selectRoute(drawerState, Routes.about)}),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return Container(
        height: drawer_height,
        child: DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color(primary),
            ),
            child: Padding(
              padding: EdgeInsets.all(common_margin),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextLocalized("title_app_token",
                            style: TextStyle(color: Colors.white)),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
            )));
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: TextLocalized(
        text,
        style: TextStyle(color: Color(secondaryText)),
      ),
      onTap: onTap,
    );
  }

  selectRoute(DrawerState state, String routeName) {
    state.selectRoute(routeName);
    Navigator.pop(context);
  }
}

class DrawerState with ChangeNotifier {
  String _selectedRouteTitle;
  StatefulWidget _selectedRoute;

  DrawerState() {
    // route by default
    selectRoute(Routes.recordings);
  }

  String get selectedRouteTitle => _selectedRouteTitle;

  selectRoute(String value) {
    switch (value) {
      case Routes.video_editor:
        _selectedRouteTitle = 'item_video_editor';
        _selectedRoute = VideoEditorScreen();
        break;
      case Routes.settings:
        _selectedRouteTitle = 'item_settings';
        _selectedRoute = SettingsScreen();
        break;
      case Routes.sdks:
        _selectedRouteTitle = 'item_sdks';
        _selectedRoute = AvailableSdksScreen();
        break;
      case Routes.clients:
        _selectedRouteTitle = 'item_clients';
        _selectedRoute = TopClientsScreen();
        break;
      case Routes.contact:
        _selectedRouteTitle = 'item_contact';
        _selectedRoute = ContactUsScreen();
        break;
      case Routes.about:
        _selectedRouteTitle = 'item_about';
        _selectedRoute = AboutScreen();
        break;
      case Routes.recordings:
      default:
        _selectedRouteTitle = 'item_recordings';
        _selectedRoute = RecordingsScreen();
    }
    notifyListeners();
  }

  StatefulWidget get selectedRoute => _selectedRoute;
}
