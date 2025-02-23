import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todolistbloc/preferences/preferences.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector(
      {Key key, @required this.activeTab, @required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.todos ? Icons.list : Icons.show_chart,
            key: tab == AppTab.todos
                ? ArchSampleKeys.todoTab
                : ArchSampleKeys.statsTab,
          ),
          title: Text(tab == AppTab.stats
              ? ArchSampleLocalizations.of(context).stats
              : ArchSampleLocalizations.of(context).todos),
        );
      }).toList(),
    );
  }
}
