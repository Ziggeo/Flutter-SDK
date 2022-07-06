import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/qr/qr_scanner_listener.dart';

class QrScannerConfig extends BaseConfig {
  bool? shouldCloseAfterSuccessfulScan;

  QrScannerEventListener? eventsListener;

  QrScannerConfig convertFromMap(Map<String, dynamic> map) {
    shouldCloseAfterSuccessfulScan = map["shouldCloseAfterSuccessfulScan"];
    return QrScannerConfig(
      shouldCloseAfterSuccessfulScan: shouldCloseAfterSuccessfulScan,
    );
  }

  QrScannerConfig({
    this.shouldCloseAfterSuccessfulScan = true,
  });

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldCloseAfterSuccessfulScan"] = shouldCloseAfterSuccessfulScan;
    return map;
  }
}
