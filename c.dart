import 'dart:io';

// --- مساعدات التحويل النصي ---
String _toPascalCase(String s) => s.split('_').map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1)).join('');
String _toCamelCase(String s) {
  List<String> parts = s.split('_');
  return parts[0] + parts.sublist(1).map((w) => w[0].toUpperCase() + w.substring(1)).join('');
}

String _getPackageName() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return 'my_app';
  final content = pubspec.readAsLinesSync();
  return content.firstWhere((line) => line.startsWith('name:')).split(':')[1].trim();
}

void main(List<String> args) {
  if (args.isEmpty) {
    print("❌ خطأ: حدد اسم الميزة. مثال: dart run scripts/create_module.dart auth login");
    return;
  }

  final String pkg = _getPackageName();
  final String moduleName = args[0].toLowerCase();
  final List<String> pages = args.length > 1 ? args.sublist(1) : [moduleName];
  final String modulePath = 'lib/modules/$moduleName';

  print('🚀 بناء ميزة [$moduleName] بنظام التسمية الصغير (Lower Case)...');

  try {
    _createDirs([
      '$modulePath/bindings',
      '$modulePath/controllers',
      '$modulePath/views',
      '$modulePath/widgets',
      'lib/app/routes'
    ]);

    for (String page in pages) {
      String pageClass = _toPascalCase(page);
      String pageVar = _toCamelCase(page);

      _createFile('$modulePath/views/${page}_view.dart', _viewContent(pageClass, page));
      _createFile('$modulePath/controllers/${page}_controller.dart', _controllerContent(pageClass));
      _createFile('$modulePath/bindings/${page}_binding.dart', _bindingContent(pageClass, page));
      _createFile('$modulePath/widgets/${page}_widget.dart', _widgetContent(pageClass));

      // تحديث الراوتر بالأسلوب الجديد
      _updateAppRoutes(pageVar, moduleName, page);
      _updateAppPages(pageVar, pageClass, moduleName, pkg);
    }

    print('✅ اكتملت المهمة يا وحش! المسارات الآن في AppRoutes بأسماء صغيرة.');
  } catch (e) {
    print("❌ خطأ: $e");
  }
}

// --- القوالب (Templates) ---

String _viewContent(String cls, String page) => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/${page}_controller.dart';

class ${cls}View extends GetView<${cls}Controller> {
  const ${cls}View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${cls}View')),
      body: const Center(child: Text('${cls}View is working')),
    );
  }
}
""";

String _controllerContent(String cls) => """
import 'package:get/get.dart';

class ${cls}Controller extends GetxController {
  // Logic here
}
""";

String _bindingContent(String cls, String page) => """
import 'package:get/get.dart';
import '../controllers/${page}_controller.dart';

class ${cls}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<${cls}Controller>(() => ${cls}Controller());
  }
}
""";

String _widgetContent(String cls) => "import 'package:flutter/material.dart';\n\nclass ${cls}Widget extends StatelessWidget {\n  const ${cls}Widget({super.key});\n  @override\n  Widget build(BuildContext context) => const SizedBox();\n}";

// --- التحديث الذكي للملفات ---

void _updateAppRoutes(String pageVar, String module, String page) {
  final file = File('lib/app/routes/app_routes.dart');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync("abstract class AppRoutes {\n  static const initial = '/';\n}");
  }

  String content = file.readAsStringSync();
  if (!content.contains('static const $pageVar =')) {
    content = content.replaceFirst('abstract class AppRoutes {', 'abstract class AppRoutes {\n  static const $pageVar = \'/$module\';');
    file.writeAsStringSync(content);
    print('📌 أضيفت Route: $pageVar');
  }
}

void _updateAppPages(String pageVar, String cls, String module, String pkg) {
  final file = File('lib/app/routes/app_pages.dart');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync("import 'package:get/get.dart';\nimport 'app_routes.dart';\n\nclass AppPages {\n  static final routes = [\n  ];\n}");
  }

  String content = file.readAsStringSync();
  String importView = "import 'package:$pkg/modules/$module/views/${pageVar}_view.dart';\n";
  String importBinding = "import 'package:$pkg/modules/$module/bindings/${pageVar}_binding.dart';\n";

  if (!content.contains(importView)) content = importView + importBinding + content;

  String getPageCode = """
    GetPage(
      name: AppRoutes.$pageVar,
      page: () => const ${cls}View(),
      binding: ${cls}Binding(),
    ),""";

  if (!content.contains('AppRoutes.$pageVar')) {
    content = content.replaceFirst('static final routes = [', 'static final routes = [\n$getPageCode');
    file.writeAsStringSync(content);
    print('📄 أضيفت GetPage: $cls');
  }
}

void _createDirs(List<String> paths) => paths.forEach((p) => Directory(p).createSync(recursive: true));
void _createFile(String p, String c) => File(p).writeAsStringSync(c);