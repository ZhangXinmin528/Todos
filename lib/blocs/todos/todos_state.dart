import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props {
    return [];
  }
}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded([this.todos = const []]);

  @override
  List<Object> get props {
    return [todos];
  }

  @override
  String toString() {
    return 'TodosLoaded{todos: $todos}';
  }
}

class TodosNotLoaded extends TodosState {}
