import 'package:dio/dio.dart';

const bool maskSensitiveApiLogData = false;

class ApiLogSanitizer {
  static const Set<String> _sensitiveKeys = {
    'authorization',
    'password',
    'password_confirmation',
    'otp',
    'token',
    'access_token',
    'refresh_token',
  };

  static Map<String, dynamic> sanitizeHeaders(Map<String, dynamic> headers) {
    final sanitized = <String, dynamic>{};
    headers.forEach((key, value) {
      sanitized[key] = _sanitizeByKey(key, value);
    });
    return sanitized;
  }

  static dynamic sanitizeData(dynamic data, {String? parentKey}) {
    if (data == null) return null;

    if (data is FormData) {
      return _sanitizeFormData(data);
    }

    if (data is Map) {
      final sanitized = <String, dynamic>{};
      data.forEach((key, value) {
        final keyString = '$key';
        sanitized[keyString] = sanitizeData(
          _sanitizeByKey(keyString, value),
          parentKey: keyString,
        );
      });
      return sanitized;
    }

    if (data is List) {
      return data
          .map((item) => sanitizeData(item, parentKey: parentKey))
          .toList(growable: false);
    }

    if (data is MultipartFile) {
      return {
        'filename': data.filename,
        'length': data.length,
        'content_type': data.contentType?.toString(),
      };
    }

    return _sanitizeByKey(parentKey, data);
  }

  static String decodeEscapedUnicode(String value) {
    final regex = RegExp(r'\\u([0-9a-fA-F]{4})');
    return value.replaceAllMapped(regex, (match) {
      final code = int.parse(match.group(1)!, radix: 16);
      return String.fromCharCode(code);
    });
  }

  static dynamic _sanitizeByKey(String? key, dynamic value) {
    if (!maskSensitiveApiLogData) return value;
    final lower = key?.toLowerCase() ?? '';
    final isSensitive = _sensitiveKeys.any(
      (sensitive) => lower == sensitive || lower.contains(sensitive),
    );
    if (!isSensitive) return value;

    if (lower == 'authorization' && value is String) {
      return _maskAuthorization(value);
    }
    return _maskValue(value);
  }

  static Map<String, dynamic> _sanitizeFormData(FormData formData) {
    final fields = <String, dynamic>{};
    for (final field in formData.fields) {
      fields[field.key] = _sanitizeByKey(field.key, field.value);
    }

    final files = formData.files
        .map(
          (file) => {
            'key': file.key,
            'file': _sanitizeByKey(file.key, file.value),
          },
        )
        .toList(growable: false);

    return {
      'type': 'multipart/form-data',
      'fields': fields,
      'files': files,
    };
  }

  static String _maskAuthorization(String value) {
    final trimmed = value.trim();
    if (!trimmed.toLowerCase().startsWith('bearer ')) {
      return _maskTokenString(trimmed);
    }
    final token = trimmed.substring(7).trim();
    return 'Bearer ${_maskTokenString(token)}';
  }

  static String _maskValue(dynamic value) {
    if (value == null) return '****';
    return _maskTokenString(value.toString());
  }

  static String _maskTokenString(String token) {
    final cleaned = token.trim();
    if (cleaned.isEmpty) return '****';
    if (cleaned.length <= 4) return '****';
    return '****${cleaned.substring(cleaned.length - 4)}';
  }
}
