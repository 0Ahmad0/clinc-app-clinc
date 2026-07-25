import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_log_sanitizer.dart';

const bool logFullApiResponse = false;
const bool logRawBodyAsIs = true;

enum ApiLogLevel { request, success, warning, error }

class ApiLogFormatter {
  static String formatRequest({
    required String requestId,
    required RequestOptions options,
    required dynamic requestBody,
  }) {
    final lines = <String>[
      'Request ID  : $requestId',
      'Method      : ${options.method}',
      'URL         : ${options.uri.path}',
    ];

    final query = Map<String, dynamic>.from(
      ApiLogSanitizer.sanitizeData(options.queryParameters) as Map,
    );
    if (query.isNotEmpty) {
      lines.add('Query       :');
      _appendMap(lines, query);
    } else {
      lines.add('Query       : null');
    }

    final headers = ApiLogSanitizer.sanitizeHeaders(options.headers);
    if (headers.isNotEmpty) {
      lines.add('Headers     :');
      _appendMap(lines, headers);
    } else {
      lines.add('Headers     : null');
    }

    if (logRawBodyAsIs) {
      lines.add('Body        :');
      lines.addAll(_indented(_asIsBody(requestBody)));
    } else {
      lines.add('Body        : ${_formatBodyPreview(requestBody)}');
    }

    return _box(title: '🚀 API REQUEST', lines: lines, level: ApiLogLevel.request);
  }

  static String formatResponse({
    required String requestId,
    required Response response,
    required int durationMs,
    required dynamic responseBody,
  }) {
    final body = _asMap(responseBody);
    final endpoint = response.requestOptions.uri.path;
    final method = response.requestOptions.method;
    final statusCode = response.statusCode ?? 0;
    final message = _stringValue(body['message']);
    final success = body['success'] ?? (body['status'] == 'success');
    final list = _extractList(body);
    final meta = _extractMeta(body);
    final pagination = _extractPagination(meta);
    final isWarn = statusCode >= 400 || success == false;

    final lines = <String>[
      'Request ID  : $requestId',
      'Status Code : $statusCode',
      'Duration    : $durationMs ms',
      'Method      : $method',
      'Endpoint    : $endpoint',
      'Message     : ${message ?? '-'}',
      'Success     : $success',
    ];

    if (list != null) {
      lines.add('Items Count : ${list.length}');
      if (!logFullApiResponse && list.isNotEmpty) {
        final preview = list.take(2).toList(growable: false);
        lines.add('Items Preview: ${_compact(preview)}');
      }
    }

    if (pagination != null) {
      lines.add('Pagination  :');
      lines.add('  Page      : ${pagination.currentPage}');
      lines.add('  Per Page  : ${pagination.perPage}');
      lines.add('  Total     : ${pagination.total}');
      lines.add('  Has More  : ${pagination.hasMore}');
    }

    if (logFullApiResponse) {
      lines.add('Body        :');
      lines.addAll(_indented(_pretty(responseBody)));
    }
    if (logRawBodyAsIs) {
      lines.add('Body Raw    :');
      lines.addAll(([('$responseBody')]));
      // lines.addAll(_indented(_asIsBody(errorBody)));
    }

    return _box(
      title: isWarn ? '⚠️ API RESPONSE' : '✅ API RESPONSE',
      lines: lines,
      level: isWarn ? ApiLogLevel.warning : ApiLogLevel.success,
    );
  }

  static String formatError({
    required String requestId,
    required DioException error,
    required int durationMs,
    required dynamic errorBody,
  }) {
    final body = _asMap(errorBody);
    final statusCode = error.response?.statusCode;
    final endpoint = error.requestOptions.uri.path;
    final method = error.requestOptions.method;
    final errorCode = _extractErrorCode(body);
    final message =
        _stringValue(body['message']) ??
        _stringValue(body['error']) ??
        error.message ??
        'Unknown error';

    final lines = <String>[
      'Request ID  : $requestId',
      'Status Code : ${statusCode ?? '-'}',
      'Method      : $method',
      'Endpoint    : $endpoint',
      'Error Code  : ${errorCode ?? '-'}',
      'Message     : ${ApiLogSanitizer.decodeEscapedUnicode(message)}',
      'Dio Type    : ${error.type.name}',
      'Duration    : $durationMs ms',
    ];

    final validation = _extractValidationErrors(body);
    if (validation.isNotEmpty) {
      lines.add('Validation Errors:');
      validation.forEach((field, errors) {
        lines.add('  $field:');
        for (final validationMessage in errors) {
          lines.add('    - $validationMessage');
        }
      });
    }

    if (logFullApiResponse && errorBody != null) {
      lines.add('Body        :');
      lines.addAll(_indented(_pretty(errorBody)));
    }
    if (logRawBodyAsIs && errorBody != null) {
      lines.add('Body Raw    :');
      lines.addAll(([_asIsBody(errorBody)]));
      // lines.addAll(_indented(_asIsBody(errorBody)));
    }

    return _box(title: '❌ API ERROR', lines: lines, level: ApiLogLevel.error);
  }

  static String _box({
    required String title,
    required List<String> lines,
    required ApiLogLevel level,
  }) {
    final color = _color(level);
    final reset = _supportsColor ? '\x1B[0m' : '';
    final top = '${color}┌────────────────────────────────────────────────────────$reset';
    final head = '${color}│ $title$reset';
    final mid = '${color}├────────────────────────────────────────────────────────$reset';
    final body = lines.map((line) => '${color}│ $line$reset').join('\n');
    final bottom =
        '${color}└────────────────────────────────────────────────────────$reset';
    return '$top\n$head\n$mid\n$body\n$bottom';
  }

  static bool get _supportsColor => !kIsWeb;

  static String _color(ApiLogLevel level) {
    if (!_supportsColor) return '';
    return switch (level) {
      ApiLogLevel.request => '\x1B[36m',
      ApiLogLevel.success => '\x1B[32m',
      ApiLogLevel.warning => '\x1B[33m',
      ApiLogLevel.error => '\x1B[31m',
    };
  }

  static void _appendMap(List<String> lines, Map<dynamic, dynamic> map) {
    map.forEach((key, value) {
      lines.add('  $key : ${_compact(value)}');
    });
  }

  static String _formatBodyPreview(dynamic body) {
    if (body == null) return 'null';
    if (body is Map) return _compact(body);
    if (body is List) return 'List(${body.length})';
    return _compact(body);
  }

  static String _compact(dynamic value) {
    if (value == null) return 'null';
    final raw = value is String ? value : const JsonEncoder().convert(value);
    return ApiLogSanitizer.decodeEscapedUnicode(raw);
  }

  static String _asIsBody(dynamic value) {
    if (value == null) return 'null';
    if (value is String) return value;
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return '$value';
    }
  }

  static String _pretty(dynamic value) {
    if (value == null) return 'null';
    final encoder = const JsonEncoder.withIndent('  ');
    final source = value is String ? _decodeJsonString(value) ?? value : value;
    final raw = source is String ? source : encoder.convert(source);
    return ApiLogSanitizer.decodeEscapedUnicode(raw);
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is String) {
      final decoded = _decodeJsonString(value);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    }
    return <String, dynamic>{};
  }

  static dynamic _decodeJsonString(String value) {
    try {
      return jsonDecode(value);
    } catch (_) {
      return null;
    }
  }

  static String? _stringValue(dynamic value) {
    if (value == null) return null;
    return ApiLogSanitizer.decodeEscapedUnicode(value.toString());
  }

  static List<dynamic>? _extractList(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map && data['data'] is List) return data['data'] as List<dynamic>;
    if (data is Map && data['items'] is List) return data['items'] as List<dynamic>;
    if (data is List) return data;
    return null;
  }

  static Map<String, dynamic>? _extractMeta(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is Map && data['meta'] is Map) {
      return Map<String, dynamic>.from(data['meta'] as Map);
    }
    if (body['meta'] is Map) {
      return Map<String, dynamic>.from(body['meta'] as Map);
    }
    return null;
  }

  static ({int? currentPage, int? perPage, int? total, bool? hasMore})?
  _extractPagination(Map<String, dynamic>? meta) {
    if (meta == null || meta.isEmpty) return null;
    final currentPage = _toInt(meta['currentPage'] ?? meta['current_page']);
    final perPage = _toInt(meta['perPage'] ?? meta['per_page']);
    final total = _toInt(meta['total']);
    final hasMore = _toBool(meta['hasMore']);
    return (
      currentPage: currentPage,
      perPage: perPage,
      total: total,
      hasMore: hasMore,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    return int.tryParse('$value');
  }

  static bool? _toBool(dynamic value) {
    if (value is bool) return value;
    if (value == null) return null;
    if ('$value' == '1') return true;
    if ('$value' == '0') return false;
    return null;
  }

  static String? _extractErrorCode(Map<String, dynamic> body) {
    final error = body['error'];
    if (error is Map && error['code'] != null) return '${error['code']}';
    if (body['code'] != null) return '${body['code']}';
    return null;
  }

  static Map<String, List<String>> _extractValidationErrors(
    Map<String, dynamic> body,
  ) {
    final candidates = <dynamic>[
      body['errors'],
      body['validation_errors'],
      if (body['error'] is Map) (body['error'] as Map)['validation_errors'],
      if (body['error'] is Map) (body['error'] as Map)['errors'],
    ];

    for (final candidate in candidates) {
      if (candidate is Map) {
        final result = <String, List<String>>{};
        candidate.forEach((key, value) {
          if (value is List) {
            result['$key'] = value
                .map(
                  (item) => ApiLogSanitizer.decodeEscapedUnicode('$item'),
                )
                .toList(growable: false);
          } else if (value != null) {
            result['$key'] = [ApiLogSanitizer.decodeEscapedUnicode('$value')];
          }
        });
        if (result.isNotEmpty) return result;
      }
    }
    return const {};
  }

  static List<String> _indented(String value) {
    return value.split('\n').map((line) => '  $line').toList(growable: false);
  }
}
