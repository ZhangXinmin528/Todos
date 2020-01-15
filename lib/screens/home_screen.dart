import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:flutter_todos/localization.dart';
import 'package:flutter_todos/models/app_tab.dart';
import 'package:todos_app_core/todos_app_core.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
      return Scaffold(
        appBar: AppBar(
          title: Text(FlutterBlocLocalizations
              .of(context)
              .appTitle),
          actions: <Widget>[
            FilterButton(visible: activeTab == AppTab.todos),
            ExtraActions(),
          ],
        ),
        body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
        floatingActionButton: FloatingActionButton(
          key: ArchSampleKeys.addTodoFab,
          onPressed: () {
            Navigator.pushNamed(context, ArchSampleRoutes.addTodo)
            ,
          },
          child: Icon(Icons.add),
          tooltip: ArchSampleLocalizations
              .of(context)
              .addTodo,
        ),
        bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) {
              BlocProvider.of<TabBloc>(context).add(UpdateTab(tab));
            }),
      );
    });
  }
}
