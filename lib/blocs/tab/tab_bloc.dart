import 'package:bloc/bloc.dart';
import 'package:flutter_todos/models/app_tab.dart';

import 'tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  // TODO: implement initialState
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    // TODO: implement mapEventToState
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
