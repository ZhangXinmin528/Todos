import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/bloc/todos/todos_state.dart';
import 'package:meta/meta.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_todos/bloc/todos/todos.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todoRepository;

  TodosBloc({@required this.todoRepository});

  @override
  // TODO: implement initialState
  TodosState get initialState => TodosLoading();

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await this.todoRepository.loadTodos();
      yield TodosLoaded(
          todos.map(Todo.fromEntity).toList()
      );
    } catch (_) {
      yield TodosNotLoaded();
    }
  }


  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((state as TodosLoaded).todos)
        ..add(event.todo);

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todoRepository.saveTodos(todos.map((todo) {
      return todo.toEntity();
    }).toList());
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodoState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) {
        return todo.id != event.todo.id;
      }).toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoaded) {
      final allComplete =
      (state as TodosLoaded).todos.every((todo) {
        return todo.complete;
      });

      final List<Todo> updatedTodos = (state as TodosLoaded)
          .todos
          .map((todo) {
        return todo.copyWith(complete: !allComplete);
      }).toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos =
      (state as TodosLoaded).todos.where((todo) {
        return !todo.complete;
      })
          .toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }


}