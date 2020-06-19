import 'package:ziggeo_example/screens/available_sdks.dart';
import 'package:ziggeo_example/screens/contact_us.dart';
import 'package:ziggeo_example/screens/recordings/recordings.dart';
import 'package:ziggeo_example/screens/settings.dart';
import 'package:ziggeo_example/screens/top_clients.dart';
import 'package:ziggeo_example/screens/video_editor.dart';

import 'screens/about.dart';
class Routes {
  static const String recordings = RecordingsScreen.routeName;
  static const String recording_details = RecordingsScreen.routeName;
  static const String video_editor = VideoEditorScreen.routeName;
  static const String settings = SettingsScreen.routeName;
  static const String sdks = AvailableSdksScreen.routeName;
  static const String clients = TopClientsScreen.routeName;
  static const String contact = ContactUsScreen.routeName;
  static const String about = AboutScreen.routeName;
}
