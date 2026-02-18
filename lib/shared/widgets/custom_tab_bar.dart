import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.statusList,
    this.showAll = true,
  });

  final List<String> statusList;
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey,
      dividerColor: Colors.grey,
      tabs: [
        if (showAll) _TabBarItem(title: "Semua", count: 0),
        ...statusList.map((label) {
          return _TabBarItem(title: label, count: 0);
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
