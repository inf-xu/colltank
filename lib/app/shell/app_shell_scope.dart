import 'package:flutter/widgets.dart';

/// 提供顶层 Shell 能力（如打开 Drawer）的上下文
class AppShellScope extends InheritedWidget {
  const AppShellScope({
    super.key,
    required this.openDrawer,
    required super.child,
  });

  final VoidCallback? openDrawer;

  static AppShellScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppShellScope>();
  }

  @override
  bool updateShouldNotify(AppShellScope oldWidget) {
    return oldWidget.openDrawer != openDrawer;
  }
}
