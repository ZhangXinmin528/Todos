import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';

abstract class StatsEvent extends Equatable{
  const StatsEvent();
}

class UpdateStates extends StatsEvent{
  final List<Todo> todos;

  const UpdateStates(this.todos);

  @override
  // TODO: implement props
  List<Object> get props => [todos];

  @override
  String toString() {
    return 'UpdateStates{todos: $todos}';
  }


}