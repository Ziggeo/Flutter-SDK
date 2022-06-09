import 'package:flutter/material.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/ziggeo.dart';

final String appToken = 'appToken';
final bool isMuted = true;
final bool shouldShowSubtitles = true;

final int maxDuration = 8;
final bool shouldAllowMultipleSelection = true;
final int mediaType = FileSelectorConfig.audioMediaType;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Ziggeo ziggeo;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ziggeo = Ziggeo(appToken);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', ziggeo: ziggeo),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.ziggeo})
      : super(key: key);
  final String title;
  final Ziggeo ziggeo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? _appToken;
  bool? _isMuted;
  bool? _shouldShowSubtitles;

  int? _maxDuration;
  bool? _shouldAllowMultipleSelection;
  int? _mediaType;

  Future<void> _incrementCounter() async {
    //test App token setting
    _appToken = await widget.ziggeo.appToken ?? '';
    //test player config
    widget.ziggeo.playerConfig = PlayerConfig(
        isMuted: isMuted, shouldShowSubtitles: shouldShowSubtitles);
    _isMuted = (await widget.ziggeo.getPlayerConfig())?.isMuted;
    _shouldShowSubtitles =
        (await widget.ziggeo.getPlayerConfig())?.shouldShowSubtitles;

    //test file selector config
    widget.ziggeo.fileSelectorConfig = FileSelectorConfig(
      maxDuration: maxDuration,
      shouldAllowMultipleSelection: shouldAllowMultipleSelection,
      mediaType: mediaType,
    );
    _shouldAllowMultipleSelection =
        (await widget.ziggeo.getFileSelectorConfig())
            ?.shouldAllowMultipleSelection;
    _maxDuration = (await widget.ziggeo.getFileSelectorConfig())?.maxDuration;
    _mediaType = (await widget.ziggeo.getFileSelectorConfig())?.mediaType;

    setState(() {
      _counter++;
      _appToken = _appToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              _appToken ?? '_appToken is null',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'PlayerConfig:',
            ),
            Text(
              'isMuted$_isMuted',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'shouldShowSubtitles$_shouldShowSubtitles',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'FileSelectorConfig:',
            ),
            Text(
              'shouldAllowMultipleSelection$_shouldAllowMultipleSelection',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'maxDuration$_maxDuration',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'mediaType$_mediaType',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
