import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todos/bloc/todos/todos.dart';
import 'package:flutter_todos/bloc/todos/todos_state.dart';
import 'package:meta/meta.dart';

import 'stats_event.dart';
import 'stats_state.dart';

class StatBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  StatBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateStates(state.todos));
      }
    });
  }

  @override
  // TODO: implement initialState
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    // TODO: implement mapEventToState
    if (event is UpdateStates) {
      int numActive = event.todos
          .where((todo) {
            return !todo.complete;
          })
          .toList()
          .length;

      int numCompleted = event.todos
          .where((todo) {
            return todo.complete;
          })
          .toList()
          .length;

      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<Function> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
