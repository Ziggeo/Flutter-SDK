import 'package:flutter/material.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/routes.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AppDrawerState();
  }
}

class _AppDrawerState extends State<AppDrawer> {
  String selectedRote = Routes.recordings;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              text: 'item_recordings',
              onTap: () => {selectRoute(Routes.recordings)}),
          _createDrawerItem(
              text: 'item_video_editor',
              onTap: () => {selectRoute(Routes.video_editor)}),
          _createDrawerItem(
              text: 'item_settings',
              onTap: () => {selectRoute(Routes.settings)}),
          Divider(),
          _createDrawerItem(
              text: 'item_sdks', onTap: () => {selectRoute(Routes.sdks)}),
          _createDrawerItem(
              text: 'item_clients', onTap: () => {selectRoute(Routes.clients)}),
          _createDrawerItem(
              text: 'item_contact', onTap: () => {selectRoute(Routes.contact)}),
          _createDrawerItem(
              text: 'item_about', onTap: () => {selectRoute(Routes.about)}),
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

  selectRoute(String routeName) {
    this.setState(() {
      selectedRote = routeName;
    });
    Navigator.pop(context);
  }
}
