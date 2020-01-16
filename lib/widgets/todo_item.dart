import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TodoItems extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> OnCheckboxChanged;
  final Todo todo;

  TodoItems(
      {Key key,
      @required this.onDismissed,
      @required this.onTap,
      @required this.OnCheckboxChanged,
      @required this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      key: ArchSampleKeys.todoItem(todo.id),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
            key: ArchSampleKeys.todoItemCheckbox(todo.id),
            value: todo.complete,
            onChanged: OnCheckboxChanged),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              style: Theme.of(context).textTheme.title,
              key: ArchSampleKeys.todoItemTask(todo.id),
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
            ? Text(
                todo.note,
                key: ArchSampleKeys.todoItemNote(todo.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              )
            : null,
      ),
    );
  }
}
