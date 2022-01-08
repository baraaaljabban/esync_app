abstract class CustomException implements Exception {}

/// Throw when there is no internet connection available
class ConnectionUnavailableException implements CustomException {}

/// Throw when the Newswav API is returning HTTP 400, which represent business logic error
///
/// [errorCode] unique error code from API represent whats the error for.
/// This can be used to distingush the logic error type and handle it accordingly
/// depending on business requirements
///
/// [title] error dialog title to show returned by API
///
/// [message] error dialog message to show returned by API
class ApiLogicException implements CustomException {
  final String errorCode;
  final String? title;
  final String? message;

  ApiLogicException({required this.errorCode, this.title, this.message});

  @override
  String toString() => 'ApiLogicException(errorCode: $errorCode, title: $title, message: $message)';
}

/// Throw when the Newswav API is returning HTTP 5xx
///
/// [statusCode] The error status returned by API.
/// Useful to either report to the Crashlytics
/// or show in the UI so that it shown in the screenshot if user send to support
///
/// [statusCode] HTTP status code
///
/// [body] raw response return from API
class ServerErrorException implements CustomException {
  final int statusCode;
  final String body;

  ServerErrorException({required this.statusCode, required this.body});

  @override
  String toString() => 'ServerErrorException(statusCode: $statusCode, body: $body)';
}

/// Throw when API is returning API status that beyond our handling
/// or something we did not handle it
///
/// [statusCode] HTTP status code
///
/// [body] raw response return from API
class UnhandledServerErrorException implements CustomException {
  final int statusCode;
  final String body;

  UnhandledServerErrorException({required this.statusCode, required this.body});

  @override
  String toString() => 'UnhandledServerErrorException(statusCode: $statusCode, body: $body)';
}
