import 'package:flutter/material.dart';
import 'package:ziggeo_example/screens/lists/list.dart';

class AvailableSdksScreen extends StatefulWidget {
  static const String routeName = 'title_sdks';

  @override
  _AvailableSdksScreenState createState() => _AvailableSdksScreenState();
}

class _AvailableSdksScreenState extends State<AvailableSdksScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: InfoList(sdks)),
    );
  }

  final sdks = [
    ListDataObject(
        url: 'https://github.com/Ziggeo/iOS-Client-SDK',
        imagePath: 'assets/img/sdks/ic_objc.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/Swift-Client-SDK',
        imagePath: 'assets/img/sdks/ic_swift.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/Android-Client-SDK',
        imagePath: 'assets/img/sdks/ic_android.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/Xamarin-SDK-Demo',
        imagePath: 'assets/img/sdks/ic_xamarin.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ReactNativeDemo',
        imagePath: 'assets/img/sdks/ic_reactnative.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/Flutter-SDK',
        imagePath: 'assets/img/sdks/ic_flutter.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoPhpSdk',
        imagePath: 'assets/img/sdks/ic_php.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoPythonSdk',
        imagePath: 'assets/img/sdks/ic_python.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoNodeSdk',
        imagePath: 'assets/img/sdks/ic_nodejs.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoRubySdk',
        imagePath: 'assets/img/sdks/ic_ruby.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoJavaSdk',
        imagePath: 'assets/img/sdks/ic_java.png'),
    ListDataObject(
        url: 'https://github.com/Ziggeo/ZiggeoCSharpSDK',
        imagePath: 'assets/img/sdks/ic_csharp.png'),
  ];
}
