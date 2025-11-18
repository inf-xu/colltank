import 'package:flutter/material.dart';

class MoodPreset {
  const MoodPreset({required this.icon, required this.color});

  final IconData icon;
  final String color;
}

const List<MoodPreset> kMoodPresets = [
  MoodPreset(icon: Icons.favorite, color: '#FFEF5350'),
  MoodPreset(icon: Icons.star, color: '#FFFFD54F'),
  MoodPreset(icon: Icons.face_retouching_natural, color: '#FF64B5F6'),
  MoodPreset(icon: Icons.nightlight_round, color: '#FF9575CD'),
  MoodPreset(icon: Icons.wb_sunny, color: '#FFFFB74D'),
  MoodPreset(icon: Icons.emoji_nature, color: '#FFA5D6A7'),
  MoodPreset(icon: Icons.emoji_emotions, color: '#FFFFE082'),
  MoodPreset(icon: Icons.emoji_food_beverage, color: '#FF8D6E63'),
];

final Map<int, MoodPreset> _presetMap = {
  for (final preset in kMoodPresets) preset.icon.codePoint: preset,
};

MoodPreset? findMoodPreset(int codePoint) => _presetMap[codePoint];

IconData resolveMoodIcon({
  required int codePoint,
  String? fontFamily,
  String? fontPackage,
}) {
  final preset = _presetMap[codePoint];
  if (preset != null) {
    return preset.icon;
  }
  return Icons.error;
}
