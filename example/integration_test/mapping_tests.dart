import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ziggeo_example/test_main.dart' as app;
import 'package:ziggeo_example/test_main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('mapping', () {
    testWidgets('mapping_success', (WidgetTester tester) async {
      app.main();
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(find.text(appToken), findsOneWidget);

      expect(find.text('isMuted$isMuted'), findsOneWidget);
      expect(
          find.text('shouldShowSubtitles$shouldShowSubtitles'), findsOneWidget);

      expect(
          find.text(
              'shouldAllowMultipleSelection$shouldAllowMultipleSelection'),
          findsOneWidget);
      expect(find.text('maxDuration$maxDuration'), findsOneWidget);
      expect(find.text('mediaType$mediaType'), findsOneWidget);

      final listFinder = find.byType(Scrollable);
      final itemFinder = find.byKey(ValueKey('shouldTurnOffUploader: '));
      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(itemFinder, findsOneWidget);
      expect(find.text('shouldUseWifiOnly$shouldUseWifiOnly'), findsOneWidget);
      expect(find.text('syncInterval$syncInterval'), findsOneWidget);
      expect(find.text('shouldTurnOffUploader$shouldTurnOffUploader'),
          findsOneWidget);

      final itemTwoFinder =
          find.byKey(ValueKey('shouldCloseAfterSuccessfulScan: '));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemTwoFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(itemTwoFinder, findsOneWidget);
      expect(
          find.text(
              'shouldCloseAfterSuccessfulScan$shouldCloseAfterSuccessfulScan'),
          findsOneWidget);

      final itemThreeFinder = find.byKey(ValueKey('shouldSendImmediately: '));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemThreeFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(itemThreeFinder, findsOneWidget);

      expect(find.text('shouldShowFaceOutline$shouldShowFaceOutline'),
          findsOneWidget);
      expect(find.text('isLiveStreaming$isLiveStreaming'), findsOneWidget);
      expect(find.text('shouldAutoStartRecording$shouldAutoStartRecording'),
          findsOneWidget);
      expect(find.text('startDelay$startDelay'), findsOneWidget);
      expect(find.text('blurMode$blurMode'), findsOneWidget);
      expect(find.text('shouldSendImmediately$shouldSendImmediately'),
          findsOneWidget);

      final itemFourFinder =
          find.byKey(ValueKey('shouldConfirmStopRecording: '));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFourFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      expect(itemFourFinder, findsOneWidget);
      expect(find.text('shouldDisableCameraSwitch$shouldDisableCameraSwitch'),
          findsOneWidget);

      expect(find.text('videoQuality$videoQuality'), findsOneWidget);
      expect(find.text('facing$facing'), findsOneWidget);
      var newDuration = app.maxDurationRec * 1000;
      expect(find.text('maxDurationRec$newDuration'), findsOneWidget);
      expect(find.text('shouldEnableCoverShot$shouldEnableCoverShot'),
          findsOneWidget);
      expect(find.text('shouldConfirmStopRecording$shouldConfirmStopRecording'),
          findsOneWidget);

      final itemFiveFinder = find.byKey(ValueKey('negBtnText: '));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemFiveFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(itemFiveFinder, findsOneWidget);

      expect(find.text('titleText$titleText'), findsOneWidget);
      expect(find.text('mesText$mesText'), findsOneWidget);
      expect(find.text('posBtnText$posBtnText'), findsOneWidget);
      expect(find.text('negBtnText$negBtnText'), findsOneWidget);

      final itemSixFinder = find.byKey(ValueKey('muteOnImageDrawable: '));

      // Scroll until the item to be found appears.
      await tester.scrollUntilVisible(
        itemSixFinder,
        50.0,
        scrollable: listFinder,
      );

      // Trigger a frame.
      await tester.pumpAndSettle();
      await binding.takeScreenshot('test-screenshot');

      expect(itemSixFinder, findsOneWidget);

      expect(find.text('textColor$textColor'), findsOneWidget);
      expect(find.text('controllerStyle$controllerStyle'), findsOneWidget);
      expect(find.text('unplayedColor$unplayedColor'), findsOneWidget);
      expect(find.text('playedColor$playedColor'), findsOneWidget);
      expect(find.text('bufferedColor$bufferedColor'), findsOneWidget);
      expect(find.text('tintColor$tintColor'), findsOneWidget);
      expect(find.text('muteOffImageDrawable$muteOffImageDrawable'),
          findsOneWidget);
      expect(
          find.text('muteOnImageDrawable$muteOnImageDrawable'), findsOneWidget);
    });
  });
}
