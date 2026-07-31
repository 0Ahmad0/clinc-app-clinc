/// Masks the identifier the verification code was sent to, so the OTP screen can
/// confirm the destination without printing it in full.
///
/// Keeps the first two characters and hides the rest; an email keeps its domain
/// (`info@clinic.sa` → `in***@clinic.sa`).
String maskIdentifier(String value) {
  final trimmed = value.trim();
  final at = trimmed.indexOf('@');
  if (at <= 0) return _maskHead(trimmed);
  return '${_maskHead(trimmed.substring(0, at))}${trimmed.substring(at)}';
}

String _maskHead(String value) =>
    value.length <= 2 ? '***' : '${value.substring(0, 2)}***';
