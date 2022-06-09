import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ziggeo_example/test_main.dart' as app;
import 'package:ziggeo_example/test_main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('mapping', () {
    testWidgets('appToken_success', (WidgetTester tester) async {
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
    });
  });

  group('mapping', () {
    testWidgets('player_config_isMuted_success', (WidgetTester tester) async {
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
      expect(find.text('isMuted$isMuted'), findsOneWidget);
    });
  });

  group('mapping', () {
    testWidgets('player_config_shouldShowSubtitles_success',
        (WidgetTester tester) async {
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

      expect(
          find.text('shouldShowSubtitles$shouldShowSubtitles'), findsOneWidget);
    });
  });

  group('mapping', () {
    testWidgets('fileSelector_config_shouldAllowMultipleSelection_success',
            (WidgetTester tester) async {
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
          expect(
              find.text('shouldAllowMultipleSelection$shouldAllowMultipleSelection'), findsOneWidget);
        });
  });

  group('mapping', () {
    testWidgets('fileSelector_config_maxDuration_success',
            (WidgetTester tester) async {
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
          expect(
              find.text('maxDuration$maxDuration'), findsOneWidget);
        });
  });

  group('mapping', () {
    testWidgets('fileSelector_config_mediaType_success',
            (WidgetTester tester) async {
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
          expect(
              find.text('mediaType$mediaType'), findsOneWidget);
        });
  });
}
