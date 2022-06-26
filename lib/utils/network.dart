import 'dart:io';

class NetworkUtilities {
  static Future<bool> isConnected() async {
    try {
      final List<InternetAddress> result =
      await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw const SocketException('');
      });
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
