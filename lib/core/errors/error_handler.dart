import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import 'exceptions.dart';
import 'failures.dart';

mixin ErrorHandler {
  /// Map the http status to the respective exception class and throw it
  ///
  /// Exception to throws:
  ///
  /// [ApiLogicException] Throws if HTTP status belongs to 400, 401, 403.
  ///
  /// [ServerErrorException] Throw is HTTP status belongs to 5xx.;
  ///
  /// [UnhandledServerErrorException] Throw for non success status that is not listed above
  CustomException getNonSuccessHttpResponseException(Response response) {
    CustomException exceptionToThrow;
    switch (response.statusCode) {
      // represent business logic error in Newswav API
      case HttpStatus.badRequest:
        exceptionToThrow = _getExceptionForLogic(response);
        break;

      // represent validation error in Newswav API
      case HttpStatus.unprocessableEntity:
        exceptionToThrow = _getExceptionForValidation(response);
        break;

      // represent either token is invalid, revoke or any related to authorisation issue
      case HttpStatus.unauthorized:
        exceptionToThrow = _getExceptionForUnauthorised(response);
        break;

      default:

        /// status code 5xx represent server error
        if (response.statusCode >= 500) {
          exceptionToThrow = _getExceptionForServerError(response);
        } else {
          // anything else listed above we consider as unhandle server error
          exceptionToThrow = _getExceptionForUnhandledError(response);
        }
        break;
    }

    return exceptionToThrow;
  }

  /// Throws [ApiLogicException] if HTTP status belongs to 400.
  CustomException _getExceptionForLogic(Response response) {
    log("400 _getExceptionForLogic ${response.statusCode}");
    return _constructLogicException(response);
  }

  /// Throws [ApiLogicException] if HTTP status belongs to 401.
  CustomException _getExceptionForUnauthorised(Response response) {
    log("_getExceptionForUnauthorised ${response.statusCode}");
    return _constructLogicException(response);
  }

  /// Throws [ApiLogicException] if HTTP status belongs to 403.
  CustomException _getExceptionForValidation(Response response) {
    log("_getExceptionForValidation ${response.statusCode}");
    return _constructLogicException(response);
  }

  /// Throws [ServerErrorException] if HTTP status belongs to 5xx.
  CustomException _getExceptionForServerError(Response response) {
    log("_getExceptionForServerError ${response.statusCode}");
    return ServerErrorException(statusCode: response.statusCode, body: response.body);
  }

  /// Throws [UnhandledServerErrorException] if HTTP status is not being handled
  CustomException _getExceptionForUnhandledError(Response response) {
    log("_getExceptionForUnhandledError ${response.statusCode}");
    return UnhandledServerErrorException(statusCode: response.statusCode, body: response.body);
  }

  /// helper to construct and map the response data to [ApiLogicException]
  CustomException _constructLogicException(Response response) {
    log("_constructLogicException ${response.statusCode}");
    Map<String, dynamic> json = jsonDecode(response.body);
    log(json.toString());
    return ApiLogicException(errorCode: json['code'], title: json['title'], message: json['message']);
  }

  /// Helper functions to map the common thrown exception to the failures accordingly
  ///
  /// NOT RECOMMEND to put any specific business logic error handling here
  ///
  /// Supported exception map to failure
  ///
  /// - FormatException => JsonFormatFailure
  /// - ConnectionUnavailableException => ConnectionUnavailableFailure
  /// - ServerErrorException => ServerFailure
  /// - UnhandledServerErrorException => UnhandledServerFailure
  /// - ApiLogicException => UnhandledLogicException. **NOTE** Passing this means logic error is not being handle at business logic side
  Failure mapCommonExceptionToFailure(Exception exception) {
    if (exception is FirebaseAuthException) {
      if (exception.code == 'weak-password') {
        return ServerFailure(message: "The password provided is too weak.");
      } else if (exception.code == 'email-already-in-use') {
        return ServerFailure(message: "The account already exists for that email.");
      } else if (exception.code == 'user-not-found') {
        return ServerFailure(message: 'No user found for that email.');
      } else if (exception.code == 'wrong-password') {
        return ServerFailure(message: 'Wrong password provided for that user.');
      } else {
        return ServerFailure(message: exception.message ?? "");
      }
    }
    if (exception is FormatException) {
      log("FormatException ${exception.message}");
      return JsonFormatFailure(message: "format_failure");
    }

    if (exception is ConnectionUnavailableException) {
      log("ConnectionUnavailableException");
      return ConnectionUnavailableFailure();
    }

    if (exception is ServerErrorException) {
      log("ServerErrorException ${exception.statusCode}");
      return ServerFailure(statusCode: exception.statusCode, message: "sever_error_failure");
    }

    if (exception is UnhandledServerErrorException) {
      log("UnhandledServerErrorException ${exception.statusCode}");
      return UnhandledServerFailure(statusCode: exception.statusCode, message: "unhandled_server_failure");
    }
    log("UnhandledFailure ${exception.toString()}");
    return UnhandledFailure(className: exception.runtimeType.toString(), message: "unhandled_failure");
  }
}
