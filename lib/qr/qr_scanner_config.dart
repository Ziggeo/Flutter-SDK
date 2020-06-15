import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/qr/qr_scanner_listener.dart';

class QrScannerConfig extends BaseConfig {
  var shouldCloseAfterSuccessfulScan = true;

  QrScannerEventListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldCloseAfterSuccessfulScan"] = shouldCloseAfterSuccessfulScan;
    return map;
  }
}
