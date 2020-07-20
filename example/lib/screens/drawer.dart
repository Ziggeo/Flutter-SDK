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
  final String appToken;

  AppDrawer(this.appToken);

  @override
  State<StatefulWidget> createState() => _AppDrawerState(appToken);
}

class _AppDrawerState extends State<AppDrawer> {
  String appToken;

  _AppDrawerState(this.appToken);

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
                    Container(
                      width: double.infinity,
                      child: Text(
                        appToken,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
  StatefulWidget selectedRoute;
  String selectedRouteTitle;

  DrawerState() {
    selectRoute(Routes.recordings);
  }

  selectRoute(String value) {
    switch (value) {
      case Routes.video_editor:
        selectedRouteTitle = 'item_video_editor';
        selectedRoute = VideoEditorScreen();
        break;
      case Routes.settings:
        selectedRouteTitle = 'item_settings';
        selectedRoute = SettingsScreen();
        break;
      case Routes.sdks:
        selectedRouteTitle = 'item_sdks';
        selectedRoute = AvailableSdksScreen();
        break;
      case Routes.clients:
        selectedRouteTitle = 'item_clients';
        selectedRoute = TopClientsScreen();
        break;
      case Routes.contact:
        selectedRouteTitle = 'item_contact';
        selectedRoute = ContactUsScreen();
        break;
      case Routes.about:
        selectedRouteTitle = 'item_about';
        selectedRoute = AboutScreen();
        break;
      case Routes.recordings:
      default:
        selectedRouteTitle = 'item_recordings';
        selectedRoute = RecordingsScreen();
    }
    notifyListeners();
  }
}
