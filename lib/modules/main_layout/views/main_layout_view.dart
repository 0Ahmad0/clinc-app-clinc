import 'package:flutter/material.dart';
import 'widgets/main_layout_nav.dart';
import 'widgets/main_layout_pages.dart';

/// Root shell of the app — pure layout, zero logic.
class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainLayoutPages(),
      bottomNavigationBar: MainLayoutNav(),
    );
  }
}
