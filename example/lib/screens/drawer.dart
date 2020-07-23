import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/routes.dart';
import 'package:ziggeo_example/screens/about.dart';
import 'package:ziggeo_example/screens/auth.dart';
import 'package:ziggeo_example/screens/available_sdks.dart';
import 'package:ziggeo_example/screens/contact_us.dart';
import 'package:ziggeo_example/screens/log.dart';
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
              isSelected: drawerState.selectedRouteName == Routes.recordings,
              text: Routes.recordings,
              onTap: () => {selectRoute(drawerState, Routes.recordings)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.video_editor,
              text: Routes.video_editor,
              onTap: () => {selectRoute(drawerState, Routes.video_editor)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.settings,
              text: Routes.settings,
              onTap: () => {selectRoute(drawerState, Routes.settings)}),
          Divider(),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.sdks,
              text: Routes.sdks,
              onTap: () => {selectRoute(drawerState, Routes.sdks)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.clients,
              text: Routes.clients,
              onTap: () => {selectRoute(drawerState, Routes.clients)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.contact,
              text: Routes.contact,
              onTap: () => {selectRoute(drawerState, Routes.contact)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.about,
              text: Routes.about,
              onTap: () => {selectRoute(drawerState, Routes.about)}),
          _createDrawerItem(
              isSelected: drawerState.selectedRouteName == Routes.log,
              text: Routes.log,
              onTap: () => {selectRoute(drawerState, Routes.log)}),
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
                        IconButton(
                            onPressed: () => showLogoutPopup(),
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            )),
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
      {IconData icon, String text, GestureTapCallback onTap, bool isSelected}) {
    return ListTile(
      selected: isSelected,
      title: TextLocalized(text),
      onTap: onTap,
    );
  }

  selectRoute(DrawerState state, String routeName) {
    state.selectRoute(routeName);
    Navigator.pop(context);
  }

  showLogoutPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            content: TextLocalized('logout_message'),
            actions: <Widget>[
              FlatButton(
                child: TextLocalized('common_no'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: TextLocalized('common_yes'),
                onPressed: () {
                  logout();
                },
              ),
            ],
          );
        });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pop();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
  }
}

class DrawerState with ChangeNotifier {
  StatefulWidget selectedRoute;
  String selectedRouteName;

  DrawerState() {
    selectRoute(Routes.recordings);
  }

  selectRoute(String value) {
    switch (value) {
      case Routes.video_editor:
        selectedRoute = VideoEditorScreen();
        break;
      case Routes.settings:
        selectedRoute = SettingsScreen();
        break;
      case Routes.sdks:
        selectedRoute = AvailableSdksScreen();
        break;
      case Routes.clients:
        selectedRoute = TopClientsScreen();
        break;
      case Routes.contact:
        selectedRoute = ContactUsScreen();
        break;
      case Routes.about:
        selectedRoute = AboutScreen();
        break;
      case Routes.log:
        selectedRoute = LogScreen();
        break;
      case Routes.recordings:
      default:
        selectedRoute = RecordingsScreen();
    }
    selectedRouteName = value;
    notifyListeners();
  }
}
