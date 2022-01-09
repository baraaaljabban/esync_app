import 'dart:developer';

import 'package:esync_app/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '/core/fixtures/server_keys.dart';
import 'connection_checker.dart';

abstract class HttpClient {
  /// hits a post request to [BASE_URL] + [url] with [body] as the as the body of the HTTP request
  ///
  /// **from** [BASE_URL] + [url]
  ///
  /// **To** `"https://"` + [url] + `"/api-backend/Authenticate/GetToken"`
  Future<http.Response> postData({
    required String url,
    required String body,
    bool isForLogin = false,
  });

  ///hits a put request to [BASE_URL] + [url] with [body] as the as the body of the HTTP request
  Future<http.Response> putData({
    required String url,
    required String body,
  });

  ///hits a get request to [BASE_URL] + [url]
  Future<http.Response> getData({
    required String url,
  });
}

class HttpClientImpl extends HttpClient {
  final SharedPreferences sharedPreferences;
  final ConnectionChecker connectionChecker;

  HttpClientImpl({
    required this.sharedPreferences,
    required this.connectionChecker,
  });

  @override
  Future<http.Response> postData({
    required String url,
    required String body,
    bool isForLogin = false,
  }) async {
    await _throwExceptionIfNoConnection();

    var finalUrl = Uri.parse(BASE_URL + url);

    log("Posting To: $finalUrl");
    var result = await http.post(
      finalUrl,
      headers: _getHeaders(),
      body: body,
    );
    log("Status Code: ${result.statusCode}");
    log("Phrase: ${result.reasonPhrase.toString()}");
    return result;
  }

  @override
  Future<http.Response> putData({
    required String url,
    required String body,
  }) async {
    var finalUrl = Uri.parse(BASE_URL + url);

    log("Putting To: $finalUrl");

    var result = await http.put(
      finalUrl,
      headers: _getHeaders(),
      body: body,
    );
    log("Status Code: ${result.statusCode}");
    log("Phrase: ${result.reasonPhrase.toString()}");
    return result;
  }

  @override
  Future<http.Response> getData({
    required String url,
  }) async {
    var finalUrl = Uri.parse(BASE_URL + url);

    log("Getting From: $finalUrl");
    var result = await http.get(
      finalUrl,
      headers: _getHeaders(),
    );
    log("Status Code: ${result.statusCode}");
    log("Phrase: ${result.reasonPhrase.toString()}");
    return result;
  }

  /// helper function to check if mobile has connection
  Future<void> _throwExceptionIfNoConnection() async {
    if (!await connectionChecker.isConnected()) {
      throw ConnectionUnavailableException();
    }
  }

  Map<String, String> _getHeaders() {
    var headers = {'Content-Type': 'application/json-patch+json'};
    headers.addAll({
      "Authorization": "Bearer ",
    });
    return headers;
  }
}
