import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// 主入口：挂载 ProviderScope，确保 Riverpod 状态全局可用
void main() {
  runApp(
    const ProviderScope(
      child: CollTankApp(),
    ),
  );
}
