import 'package:flutter/material.dart';

/// 我的页面占位
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('存储统计占位'),
            subtitle: Text('展示空间占用 / 最近导出路径'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('应用设置占位'),
            subtitle: Text('复制/移动策略、目录授权等'),
          ),
        ],
      ),
    );
  }
}
