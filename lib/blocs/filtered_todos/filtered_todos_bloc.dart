import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/bloc/filtered_todos/filtered_todos_event.dart';
import 'package:flutter_todos/bloc/filtered_todos/filtered_todos_state.dart';
import 'package:flutter_todos/bloc/todos/todos.dart';
import 'package:flutter_todos/bloc/todos/todos_state.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_todos/models/visibility_filter.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;

  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateTodos((todosBloc.state as TodosLoaded).todos));
      }
    });
  }

  @override
  // TODO: implement initialState
  FilteredTodosState get initialState {
    return todosBloc.state is TodosLoaded
        ? FilteredTodosLoaded(
            (todosBloc.state as TodosLoaded).todos, VisibilityFilter.all)
        : FilteredTodosLoading();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      UpdateFilter event) async* {
    if (todosBloc.state is TodosLoaded) {
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoaded).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(UpdateTodos event) async* {
    final visibilityFilter = state is FilteredTodosLoaded
        ? (state as FilteredTodosLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
            (todosBloc.state as TodosLoaded).todos, visibilityFilter),
        visibilityFilter);
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }
}
