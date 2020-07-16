import 'package:flutter/material.dart';
import 'package:ziggeo_example/screens/lists/list.dart';

class AvailableSdksScreen extends StatefulWidget {
  static const String routeName = '/sdks';

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
    ListDataObject('https://github.com/Ziggeo/iOS-Client-SDK',
        'assets/img/sdks/ic_objc.png'),
    ListDataObject('https://github.com/Ziggeo/Swift-Client-SDK',
        'assets/img/sdks/ic_swift.png'),
    ListDataObject('https://github.com/Ziggeo/Android-Client-SDK',
        'assets/img/sdks/ic_android.png'),
    ListDataObject('https://github.com/Ziggeo/Xamarin-SDK-Demo',
        'assets/img/sdks/ic_xamarin.png'),
    ListDataObject('https://github.com/Ziggeo/ReactNativeDemo',
        'assets/img/sdks/ic_reactnative.png'),
    ListDataObject('https://github.com/Ziggeo/Flutter-SDK',
        'assets/img/sdks/ic_flutter.png'),
    ListDataObject(
        'https://github.com/Ziggeo/ZiggeoPhpSdk', 'assets/img/sdks/ic_php.png'),
    ListDataObject('https://github.com/Ziggeo/ZiggeoPythonSdk',
        'assets/img/sdks/ic_python.png'),
    ListDataObject('https://github.com/Ziggeo/ZiggeoNodeSdk',
        'assets/img/sdks/ic_nodejs.png'),
    ListDataObject('https://github.com/Ziggeo/ZiggeoRubySdk',
        'assets/img/sdks/ic_ruby.png'),
    ListDataObject('https://github.com/Ziggeo/ZiggeoJavaSdk',
        'assets/img/sdks/ic_java.png'),
    ListDataObject('https://github.com/Ziggeo/ZiggeoCSharpSDK',
        'assets/img/sdks/ic_csharp.png'),
  ];
}
