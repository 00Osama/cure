import 'package:flutter/material.dart';

class DashboardTabItem extends StatelessWidget {
  const DashboardTabItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final tabWidth = MediaQuery.of(context).size.width / 4;

    return Tab(
      child: SizedBox(
        width: tabWidth,
        child: Center(child: Text(title, overflow: TextOverflow.ellipsis)),
      ),
    );
  }
}
