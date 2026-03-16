import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  // ── Teal (Splash, Login, OTP, Welcome) ──────────────────────────────────
  static const LinearGradient teal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF004D40), Color(0xFF009688), Color(0xFF00ACC1)],
  );

  static const LinearGradient tealLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF009688), Color(0xFF00ACC1)],
  );

  // ── Indigo (Register) ────────────────────────────────────────────────────
  static const LinearGradient indigo = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
  );

  static const LinearGradient indigoLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3949AB), Color(0xFF5C6BC0)],
  );

  // ── Amber / Orange (ForgotPassword, PendingApproval) ─────────────────────
  static const LinearGradient amber = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB45309), Color(0xFFF59E0B), Color(0xFFFBBF24)],
  );

  static const LinearGradient amberLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  );

  // ── Purple (Profile, Settings) ────────────────────────────────────────────
  static const LinearGradient purple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4527A0), Color(0xFF673AB7), Color(0xFF9575CD)],
  );

  static const LinearGradient purpleLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF673AB7), Color(0xFF9575CD)],
  );

  // ── Green (Success states) ────────────────────────────────────────────────
  static const LinearGradient green = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
  );

  // ── Red (Error / Danger) ─────────────────────────────────────────────────
  static const LinearGradient red = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB71C1C), Color(0xFFE53935), Color(0xFFEF5350)],
  );

  // ── Blue (Services) ──────────────────────────────────────────────────────────
  static const LinearGradient blue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E1B4B), Color(0xFF1E3A8A), Color(0xFF2563EB)],
  );

  static const LinearGradient blueLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
  );

  // ── Shadow colors per gradient ────────────────────────────────────────────
  static const Color tealShadow   = Color(0x60009688);
  static const Color indigoShadow = Color(0x603949AB);
  static const Color amberShadow  = Color(0x60F59E0B);
  static const Color purpleShadow = Color(0x60673AB7);
  static const Color greenShadow  = Color(0x6043A047);
  static const Color redShadow    = Color(0x60E53935);
  static const Color blueShadow   = Color(0x602563EB);
}
