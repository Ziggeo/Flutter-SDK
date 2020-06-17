import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static sendEmail(String address) async {
    final Email email = Email(
      recipients: [address],
    );

    await FlutterEmailSender.send(email);
  }

  static openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
