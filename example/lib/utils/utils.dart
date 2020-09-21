import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ziggeo_example/res/dimens.dart';

class Utils {
  static const String keyAppToken = "app_token";

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

  static showToast(BuildContext context, String text) {
    Widget widget = Container(
        padding: const EdgeInsets.all(toastPadding),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(shadowOpacity),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
            )
          ],
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
        ),
        child: Text(text));

    FToast().showToast(
      child: widget,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: duration),
    );
  }
}
