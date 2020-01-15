import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/todos/todos.dart';
import 'package:flutter_todos/flutter_todos_keys.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'screens.dart';

///The DetailsScreen displays the full details of the selected
///todo and allows the user to either edit or delete the todo.
class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key key, @required this.id})
      : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
      final todo = (state as TodosLoaded).todos.firstWhere((todo) {
        return todo.id == id;
      }, orElse: () {
        return null;
      });
      final localizations = ArchSampleLocalizations.of(context);

      return Scaffold(
        appBar: AppBar(
          title: Text(localizations.todoDetails),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                  Navigator.pop(context, todo);
                })
          ],
        ),
        body: todo == null
            ? Container(
                key: FlutterTodosKeys.emptyDetailsContainer,
              )
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Checkbox(
                            key: FlutterTodosKeys.detailsScreenCheckBox,
                            value: todo.complete,
                            onChanged: (_) {
                              BlocProvider.of<TodosBloc>(context).add(
                                UpdateTodo(
                                  todo.copyWith(complete: !todo.complete),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: '${todo.id}__herotag',
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 16.0,
                                  ),
                                  child: Text(
                                    todo.task,
                                    key: ArchSampleKeys.detailsTodoItemTask,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                ),
                              ),
                              Text(
                                todo.note,
                                key: ArchSampleKeys.detailsTodoItemNote,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          key: ArchSampleKeys.editTodoFab,
          tooltip: localizations.editTodo,
          child: Icon(Icons.edit),
          onPressed: todo == null
              ? null
              : () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AddEditScreen(
                          key: ArchSampleKeys.editTodoScreen,
                          onSave: (task, note) {
                            BlocProvider.of<TodosBloc>(context).add(
                              UpdateTodo(
                                todo.copyWith(task: task, note: note),
                              ),
                            );
                          },
                          isEditing: true,
                          todo: todo,
                        );
                      },
                    ),
                  );
                },
        ),
      );
    });
  }
}
