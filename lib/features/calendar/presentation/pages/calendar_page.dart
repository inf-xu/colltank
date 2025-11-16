import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../shared/utils/color_utils.dart';
import '../../../collections/domain/entities/collection_models.dart';
import '../../domain/entities/calendar_entities.dart';
import '../providers/calendar_providers.dart';

/// 日历统计页面：上方日历，下方列表
class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day);
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(calendarYearlyStatsProvider(_focusedDay.year));
    final groupsAsync = ref.watch(calendarDailyGroupsProvider(_selectedDay));
    return Scaffold(
      appBar: AppBar(
        title: const Text('日历'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCalendar(statsAsync),
          Expanded(
            child: groupsAsync.when(
              data: (groups) => _DailyGroupsList(
                groups: groups,
                selectedDate: _selectedDay,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('加载失败：$error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(AsyncValue<List<DailyCollectibleCount>> statsAsync) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    final counts = statsAsync.asData?.value ?? const [];
    final highlights = {
      for (final item in counts)
        DateTime(item.date.year, item.date.month, item.date.day): item.count,
    };
    final firstDay = DateTime(_focusedDay.year - 3, 1, 1);
    final lastDay = DateTime(_focusedDay.year + 3, 12, 31);
    return Material(
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar<void>(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: _focusedDay,
            calendarFormat: _format,
            availableCalendarFormats: const {
              CalendarFormat.month: '月视图',
              CalendarFormat.week: '周视图',
            },
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onFormatChanged: (format) {
              if (_format != format) {
                setState(() => _format = format);
              }
            },
            onPageChanged: (focusedDay) => setState(() {
              _focusedDay = focusedDay;
            }),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) => _CalendarCell(
                day: day,
                count: highlights[DateTime(day.year, day.month, day.day)] ?? 0,
                isSelected: isSameDay(day, _selectedDay),
                primaryColor: accent,
              ),
              todayBuilder: (context, day, _) => _CalendarCell(
                day: day,
                count: highlights[DateTime(day.year, day.month, day.day)] ?? 0,
                isToday: true,
                isSelected: isSameDay(day, _selectedDay),
                primaryColor: accent,
              ),
              selectedBuilder: (context, day, _) => _CalendarCell(
                day: day,
                count: highlights[DateTime(day.year, day.month, day.day)] ?? 0,
                isSelected: true,
                primaryColor: accent,
              ),
            ),
          ),
          if (statsAsync.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(minHeight: 2),
            ),
          if (statsAsync.hasError)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '无法加载上传统计',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: theme.colorScheme.error),
                ),
              ),
            ),
        ],
      ),
    );
  }

}

class _CalendarCell extends StatelessWidget {
  const _CalendarCell({
    required this.day,
    required this.count,
    required this.primaryColor,
    this.isToday = false,
    this.isSelected = false,
  });

  final DateTime day;
  final int count;
  final Color primaryColor;
  final bool isToday;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = isSelected
        ? primaryColor
        : count > 0
            ? primaryColor.withValues(alpha: 0.12)
            : isToday
                ? primaryColor.withValues(alpha: 0.08)
                : Colors.transparent;
    final textColor = isSelected
        ? Colors.white
        : theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: baseColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (count > 0)
            Text(
              '$count 件',
              style: TextStyle(
                color: textColor.withValues(alpha: 0.8),
                fontSize: 11,
              ),
            )
        ],
      ),
    );
  }
}

class _DailyGroupsList extends StatefulWidget {
  const _DailyGroupsList({required this.groups, required this.selectedDate});

  final List<CalendarCollectionGroup> groups;
  final DateTime selectedDate;

  @override
  State<_DailyGroupsList> createState() => _DailyGroupsListState();
}

class _DailyGroupsListState extends State<_DailyGroupsList> {
  late final Map<int, bool> _collapsed;

  @override
  void initState() {
    super.initState();
    _collapsed = {for (final group in widget.groups) group.collectionId: false};
  }

  @override
  void didUpdateWidget(covariant _DailyGroupsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _collapsed
        ..clear()
        ..addEntries(widget.groups.map((g) => MapEntry(g.collectionId, false)));
    } else {
      for (final group in widget.groups) {
        _collapsed.putIfAbsent(group.collectionId, () => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groups.isEmpty) {
      return _EmptyHint(date: widget.selectedDate);
    }
    final cards = widget.groups.map((group) {
      final collapsed = _collapsed[group.collectionId] ?? false;
      final accent = _resolveColor(group.accentColor, const Color(0xFF26A69A));
      return _CategoryPanel(
        group: group,
        isCollapsed: collapsed,
        accent: accent,
        onToggle: () {
          setState(() {
            _collapsed[group.collectionId] = !collapsed;
          });
        },
      );
    }).toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: cards,
    );
  }
}

class _CategoryPanel extends StatelessWidget {
  const _CategoryPanel({
    required this.group,
    required this.isCollapsed,
    required this.accent,
    required this.onToggle,
  });

  final CalendarCollectionGroup group;
  final bool isCollapsed;
  final Color accent;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: parseHexColor(group.accentColor),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  group.collectionName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${group.items.length} 件',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      visualDensity: VisualDensity.compact,
                      onPressed: onToggle,
                      icon: Icon(isCollapsed ? Icons.expand_more : Icons.expand_less, color: Colors.white,),
                    ),
                  ],
                )
              ],
            ),
            AnimatedCrossFade(
              crossFadeState:
                  isCollapsed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 200),
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                children: group.items
                    .map((item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor:
                                _resolveColor(item.moodColor, accent).withValues(alpha: 0.15),
                            child: Icon(
                              _resolveMoodIcon(item),
                              color: _resolveColor(item.moodColor, accent),
                            ),
                          ),
                          title: Text(item.displayName, style: TextStyle(color: Colors.white),),
                          subtitle: Text(_normalizeStory(item.story), style: TextStyle(color: Colors.white)),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_food_beverage_outlined, size: 48),
          const SizedBox(height: 12),
          Text('这天还没有收藏记录', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(_formatDate(date), style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

Color _resolveColor(String? hex, Color fallback) {
  if (hex == null || hex.isEmpty) {
    return fallback;
  }
  try {
    return parseHexColor(hex);
  } catch (_) {
    return fallback;
  }
}

IconData _resolveMoodIcon(CollectibleEntity collectible) {
  final fontFamily = collectible.moodFontFamily.isNotEmpty
      ? collectible.moodFontFamily
      : 'MaterialIcons';
  final fontPackage = (collectible.moodPackage?.isNotEmpty ?? false)
      ? collectible.moodPackage
      : (fontFamily.contains('Cupertino') ? 'cupertino_icons' : null);
  return IconData(
    collectible.moodCodePoint,
    fontFamily: fontFamily,
    fontPackage: fontPackage,
  );
}

String _normalizeStory(String? story) {
  if (story == null) return '暂无物语';
  final trimmed = story.trim();
  return trimmed.isEmpty ? '暂无物语' : trimmed;
}

String _formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}年$month月$day日';
}
