import 'package:flutter/material.dart';

/// 将十六进制字符串转换为 Color，默认补齐 Alpha
Color parseHexColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 7) {
    buffer.write('ff');
  }
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
