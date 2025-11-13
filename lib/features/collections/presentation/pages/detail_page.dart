import 'package:flutter/material.dart';

/// 收集罐详情页：画框 + 功能按钮 + 瀑布流占位
class CollectionDetailPage extends StatelessWidget {
  const CollectionDetailPage({
    super.key,
    required this.collectionId,
  });

  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收集罐 #$collectionId'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber),
              ),
              child: const Center(child: Text('3×3 画框占位')),
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ElevatedButton(onPressed: null, child: Text('切换画框')),
                ElevatedButton(onPressed: null, child: Text('导出拼贴')),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey.shade300,
                  child: Center(child: Text('瀑布流 $index')),
                );
              },
              itemCount: 9,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
