import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_todos/models/visibility_filter.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props {
    return [];
  }
}

class FilteredTodosLoading extends FilteredTodosState {}

class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;

  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(this.filteredTodos, this.activeFilter);

  @override
  List<Object> get props {
    return [filteredTodos, activeFilter];
  }

  @override
  String toString() {
    return 'FilteredTodosLoaded{filteredTodos: $filteredTodos, activeFilter: $activeFilter}';
  }
}
