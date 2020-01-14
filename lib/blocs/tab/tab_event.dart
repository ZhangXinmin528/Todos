import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/app_tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  const UpdateTab(this.tab);

  @override
  // TODO: implement props
  List<Object> get props => [tab];

  @override
  String toString() {
    return 'UpdateTab{tab: $tab}';
  }
}
