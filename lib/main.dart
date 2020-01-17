import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

import 'localization.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      create: (context) {
        return TodosBloc(
          todoRepository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..add(LoadTodos());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) {
                  return TabBloc();
                },
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) {
                  return FilteredTodosBloc(
                    todosBloc: BlocProvider.of<TodosBloc>(context),
                  );
                },
              ),
              BlocProvider<StatsBloc>(
                create: (context) {
                  return StatsBloc(
                    todosBloc: BlocProvider.of<TodosBloc>(context),
                  );
                },
              ),
            ],
            child: HomeScreen(),
          );
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            isEditing: false,
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context)
                  .add(AddTodo(Todo(task, note: note)));
            },
          );
        },
      },
    );
  }
}
