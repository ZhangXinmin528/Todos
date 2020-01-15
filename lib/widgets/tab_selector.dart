import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/models/app_tab.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/models/models.dart';

class TabSelector extends StatelessWidget{

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector(this.activeTab, this.onTabSelected);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ;
  }

}