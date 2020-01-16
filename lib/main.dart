import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/models/models.dart';
import 'screens/screens.dart';
import 'package:path_provider/path_provider.dart';
import 'localization.dart';
import 'package:bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(create: (context){
    return TodosBloc(todoRepository: const TodosRepositoryFlutter(
      fileStorage: const FileStorage(
        '__flutter_bloc_app__',

      ),
    ));
  }));
}

