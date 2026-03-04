import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.statusList,
    this.count = 0,
    this.counts,
    this.showAll = true,
  });

  final List<String> statusList;
  final bool showAll;

  /// Single count shown on every tab (legacy / fallback).
  final int count;

  /// Per-tab counts. When provided, overrides [count] for each tab.
  /// Index 0 is 'Semua' (if [showAll] is true), then statusList entries follow.
  final List<int>? counts;

  @override
  Widget build(BuildContext context) {
    int pos = 0;
    int _countAt() {
      if (counts == null) return count;
      final i = pos < counts!.length ? counts![pos] : 0;
      pos++;
      return i;
    }

    return TabBar(
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.grey,
      tabs: [
        if (showAll) _TabBarItem(title: "Semua", count: _countAt()),
        ...statusList.map((label) {
          return _TabBarItem(title: label, count: _countAt());
        }),
      ],
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
