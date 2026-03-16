import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  // ── Constants ──────────────────────────────────────────────────────────────

  static const int pagesCount = 3;

  // ── State ──────────────────────────────────────────────────────────────────

  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  bool get isLast => currentIndex.value == pagesCount - 1;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onReady() {
    super.onReady();
    // Set once here — not on every build() call
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // ── Commands ───────────────────────────────────────────────────────────────

  void onPageChanged(int i) => currentIndex.value = i;

  void next() {
    if (isLast) return;
    pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void skip()       => Get.offAllNamed(AppRoutes.login);
  void getStarted() => Get.offAllNamed(AppRoutes.login);

  // ── Data ───────────────────────────────────────────────────────────────────

  /// Gradient colour stops for each onboarding page.
  List<Color> gradientForPage(int index) => switch (index) {
    0 => [const Color(0xFF006064), const Color(0xFF00838F), const Color(0xFFE0F7FA)],
    1 => [const Color(0xFF1A237E), const Color(0xFF3949AB), const Color(0xFFE8EAF6)],
    _ => [const Color(0xFF004D40), const Color(0xFF00695C), const Color(0xFFE0F2F1)],
  };
}
