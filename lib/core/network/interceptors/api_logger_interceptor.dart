import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/api_log_formatter.dart';
import '../utils/api_log_sanitizer.dart';

class ApiLoggerInterceptor extends Interceptor {
  static const _extraRequestId = 'api_request_id';
  static const _extraStartAtMs = 'api_request_start_ms';
  static int _counter = 0;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(options);
      return;
    }

    final requestId = _generateRequestId();
    options.extra[_extraRequestId] = requestId;
    options.extra[_extraStartAtMs] = DateTime.now().millisecondsSinceEpoch;

    final sanitizedBody = ApiLogSanitizer.sanitizeData(options.data);
    final requestLog = ApiLogFormatter.formatRequest(
      requestId: requestId,
      options: options,
      requestBody: sanitizedBody,
    );
    _printLog(requestLog);
    handler.next(options);
  }


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(response);
      return;
    }

    final requestId = _requestId(response.requestOptions);
    final durationMs = _durationMs(response.requestOptions);
    final rawBody = _decodeBody(response.data);
    final sanitizedBody = ApiLogSanitizer.sanitizeData(rawBody);
    final responseLog = ApiLogFormatter.formatResponse(
      requestId: requestId,
      response: response,
      durationMs: durationMs,
      responseBody: sanitizedBody,
    );
    _printLog(responseLog);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      handler.next(err);
      return;
    }

    final requestId = _requestId(err.requestOptions);
    final durationMs = _durationMs(err.requestOptions);
    final rawErrorBody = _decodeBody(err.response?.data);
    final sanitizedErrorBody = ApiLogSanitizer.sanitizeData(rawErrorBody);
    final errorLog = ApiLogFormatter.formatError(
      requestId: requestId,
      error: err,
      durationMs: durationMs,
      errorBody: sanitizedErrorBody,
    );
    _printLog(errorLog);
    handler.next(err);
  }

  dynamic _decodeBody(dynamic body) {
    if (body is String) {
      final trimmed = body.trim();
      if (trimmed.isEmpty) return null;
      try {
        return jsonDecode(trimmed);
      } catch (_) {
        return ApiLogSanitizer.decodeEscapedUnicode(trimmed);
      }
    }
    return body;
  }

  String _requestId(RequestOptions options) {
    return '${options.extra[_extraRequestId] ?? _generateRequestId()}';
  }

  int _durationMs(RequestOptions options) {
    final startedAt = options.extra[_extraStartAtMs];
    final startMs = startedAt is int ? startedAt : DateTime.now().millisecondsSinceEpoch;
    return DateTime.now().millisecondsSinceEpoch - startMs;
  }

  String _generateRequestId() {
    _counter++;
    final seed =
        DateTime.now().microsecondsSinceEpoch ^
        Random().nextInt(1 << 20) ^
        _counter;
    return seed.toRadixString(16).toUpperCase().padLeft(6, '0').substring(0, 6);
  }

  void _printLog(String message) {
    // Avoid losing long response bodies in a single debugPrint call.
    const chunkSize = 800;
    for (var i = 0; i < message.length; i += chunkSize) {
      final end = (i + chunkSize < message.length)
          ? i + chunkSize
          : message.length;
      debugPrint(message.substring(i, end));
    }
  }
}
