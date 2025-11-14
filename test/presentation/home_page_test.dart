import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:colltank/features/collections/domain/entities/collection_models.dart';
import 'package:colltank/features/collections/presentation/pages/home_page.dart';
import 'package:colltank/features/collections/presentation/providers/home_providers.dart';

void main() {
  testWidgets('HomePage 展示收集罐卡片与添加按钮', (tester) async {
    final now = DateTime(2024, 1, 1, 12);
    final collections = [
      CollectionEntity(
        id: 1,
        name: '测试收藏',
        description: '用于 Widget 测试',
        sortIndex: 0,
        frameStyleId: 1,
        accentColor: '#FFA726',
        createdAt: now,
        updatedAt: now,
        itemCount: 5,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeCollectionsProvider.overrideWith(
            (ref) => Stream.value(collections),
          ),
          homeMonthlyHeatmapProvider.overrideWith(
            (ref, __) => Stream.value(List<int>.filled(30, 0)),
          ),
          homeLatestUploadProvider.overrideWith(
            (ref, __) => Stream.value(DateTime(2024, 1, 1)),
          ),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );

    await tester.pump();

    expect(find.text('收集罐'), findsOneWidget);
    expect(find.text('测试收藏'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsWidgets);
  });
}
