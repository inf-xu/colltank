import 'package:flutter/material.dart';

/// 日历页面占位
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日历'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('日历 + 热力图占位'),
      ),
    );
  }
}
