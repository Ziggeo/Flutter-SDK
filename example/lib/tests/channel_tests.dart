import 'package:ziggeo/ziggeo.dart';

///This class is for testing platform channel.
///There is no way to test it using standard approaches
class ChannelTest {
  static final _testToken = "tt";
  Ziggeo _ziggeo;

  ChannelTest(Ziggeo ziggeo) {
    this._ziggeo = ziggeo;
  }

  Future<bool> runTests() async {
    return await testAppToken() &&
        await testServerAuthToken() &&
        await testClientAuthToken();
  }

  Future<bool> testAppToken() async {
    _ziggeo.setAppToken(_testToken);
    var token = await _ziggeo.appToken;
    if (token == _testToken) {
      return true;
    } else {
      print("Error: testAppToken");
      return false;
    }
  }

  Future<bool> testServerAuthToken() async {
    _ziggeo.setServerAuthToken(_testToken);
    var token = await _ziggeo.serverAuthToken;
    if (token == _testToken) {
      return true;
    } else {
      print("Error: testServerAuthToken");
      return false;
    }
  }

  Future<bool> testClientAuthToken() async {
    _ziggeo.setClientAuthToken(_testToken);
    var token = await _ziggeo.clientAuthToken;
    if (token == _testToken) {
      return true;
    } else {
      print("Error: testClientAuthToken");
      return false;
    }
  }
}
