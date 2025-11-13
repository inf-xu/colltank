import 'package:flutter/material.dart';

/// 首页（收集罐列表）占位
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收集罐'),
        centerTitle: true,
      ),
      drawer: const _CollectionsDrawer(),
      body: const Center(
        child: Text('首页内容待实现：滚轮卡片 / 抽屉 / 添加按钮'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CollectionsDrawer extends StatelessWidget {
  const _CollectionsDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(
              leading: Icon(Icons.collections),
              title: Text('类别列表占位'),
              subtitle: Text('未来可拖拽排序 / 编辑 / 删除'),
            ),
          ],
        ),
      ),
    );
  }
}
