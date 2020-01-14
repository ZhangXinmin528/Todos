import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_todos/models/visibility_filter.dart';

abstract class FilteredTodosEvent extends Equatable{

  const FilteredTodosEvent();
}

class UpdateFilter extends FilteredTodosEvent{
  final VisibilityFilter filter;

 const UpdateFilter(this.filter);

  @override
  // TODO: implement props
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'UpdateFilter{filter: $filter}';
  }

}

class UpdateTodos extends FilteredTodosEvent{
  final List<Todo> todos;

  const UpdateTodos(this.todos);

  @override
  // TODO: implement props
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'UpdateTodos{todos: $todos}';
  }


}