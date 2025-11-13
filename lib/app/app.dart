import 'package:flutter/material.dart';

/// CollTank 全局入口，负责注入主题与路由骨架
class CollTankApp extends StatelessWidget {
  const CollTankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CollTank',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const _PlaceholderHome(),
    );
  }
}

/// 开发阶段临时页面，后续用真实路由替换
class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('收集罐原型')),
      body: const Center(
        child: Text('请根据 Riverpod 状态与 Drift 数据继续搭建页面'),
      ),
    );
  }
}
