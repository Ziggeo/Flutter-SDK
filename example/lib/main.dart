import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/tests/channel_tests.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Ziggeo _ziggeo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final String appToken = "TOKEN_HERE";
    _ziggeo = new Ziggeo(appToken);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin test app'),
        ),
        body: TestRunnerPage(_ziggeo),
      ),
    );
  }
}

class TestRunnerPage extends StatelessWidget {
  final Ziggeo _ziggeo;

  TestRunnerPage(this._ziggeo);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          var tester = new ChannelTest(_ziggeo);
          var success = await tester.runTests();
          var text;
          if (success) {
            text = "Success";
          } else {
            text = "Error";
          }
          final snackBar = SnackBar(
            content: Text(text),
          );

          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Run tests'),
      ),
    );
  }
}
