import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ziggeo/ziggeo.dart';

void main() => runApp(MyApp());

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
    final String appToken = "tt";
    _ziggeo = new Ziggeo(appToken);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
    });
  }

  Future<void> testAppToken() async {
    final String testToken = "tt";
    _ziggeo.setAppToken(testToken);
    var token = await _ziggeo.appToken;
    assert(token == testToken);
  }

  Future<void> testServerAuthToken() async {
    final String testToken = "tt";
    _ziggeo.setServerAuthToken(testToken);
    var token = await _ziggeo.serverAuthToken;
    assert(token == testToken);
  }

  Future<void> testClientAuthToken() async {
    final String testToken = "tt";
    _ziggeo.setClientAuthToken(testToken);
    var token = await _ziggeo.clientAuthToken;
    assert(token == testToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: new GestureDetector(
          onTap: _onPressed,
          child: new Text("Press me"),
        )),
      ),
    );
  }

  void _onPressed() {
    var args = {"tags": "bla"};
    _ziggeo.startCameraRecorder();
  }
}
