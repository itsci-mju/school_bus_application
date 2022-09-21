import 'dart:convert';

import 'package:http/http.dart';

/// The class that wraps the **Line Notify API**.
abstract class LineNotify {
  /// Returns the new instance of [LineNotify]
  factory LineNotify({required String token}) => _LineNotify(token: token);

  /// Sends [message] and returns the http response.
  Future<Response> send({required String message});
}

class _LineNotify implements LineNotify {
  /// The uri authority
  static const String _urlAuthority = 'notify-api.line.me';

  /// The url unencoded path
  static const String _uriEncodedPath = '/api/notify';

  /// The api token
  final String token;

  /// Returns the new instance of [LineNotify].
  _LineNotify({required this.token});

  @override
  Future<Response> send({required String message}) async => await post(
    Uri.https(_urlAuthority, _uriEncodedPath),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      "Content-Length": "${message.length + "message=".length}",
    },
    body: "message=$message",
    encoding: Encoding.getByName('UTF-8'),
  );
}