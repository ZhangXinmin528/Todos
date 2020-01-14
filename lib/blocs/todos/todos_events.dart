import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class LoadTodos extends TodosEvent {}

class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo);

  @override
  List<Object> get props {
    return [todo];
  }

  @override
  String toString() {
    return 'AddTodo{todo: $todo}';
  }
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo);

  @override
  List<Object> get props {
    return [updatedTodo];
  }

  @override
  String toString() {
    return 'UpdateTodo{updatedTodo: $updatedTodo}';
  }
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props {
    return [todo];
  }

  @override
  String toString() {
    return 'DeleteTodo{todo: $todo}';
  }
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
