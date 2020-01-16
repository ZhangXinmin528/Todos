import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:flutter_todos/flutter_todos_keys.dart';
import 'package:flutter_todos/widgets/delete_todo_snack_bar.dart';
import 'package:flutter_todos/widgets/loading_indicator.dart';
import 'package:flutter_todos/widgets/todo_item.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_todos/screens/screens.dart';

///The FilteredTodos widget is responsible for showing a list of
///todos based on the current active filter.
class FilteredTodos extends StatelessWidget{


  FilteredTodos({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
   final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredTodosBloc,FilteredTodosState>(builder: (context,state){
      if(state is FilteredTodosLoading){
        return LoadingIndicator(key: ArchSampleKeys.todosLoading,);
      }else if(state is FilteredTodosLoaded){
        final todos = state.filteredTodos;
        return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context,int index){
          final todo = todos[index];
          return TodoItems(
              onDismissed: (direction){
                BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                Scaffold.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      key: ArchSampleKeys.snackbar,
                        todo: todo,
                        onUndo: (){
                          BlocProvider.of(context).add(AddTodo(todo));
                        },
                        localizations: localizations));
              },
              onTap: () async{
                final removedTodo = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_){
                      return DetailsScreen(id: todo.id);
                }));
                if(removedTodo !=null){
                  Scaffold.of(context).showSnackBar(
                      DeleteTodoSnackBar(todo: todo, onUndo: (){
                        BlocProvider.of<TodosBloc>(context)
                            .add(AddTodo(todo));
                      }, localizations: localizations));
                }
              },
              OnCheckboxChanged: (_){
                BlocProvider.of<TodosBloc>(context).add(
                    UpdateTodo(todo.copyWith(complete: !todo.complete)));
              },
              todo: todo);
            });
      }else{
        return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer,);
      }
    });
  }


}