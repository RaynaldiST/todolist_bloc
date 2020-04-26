import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/blocs/filtered/filtered_todo.dart';
import 'package:todolistbloc/blocs/todos/todos.dart';
import 'package:todolistbloc/flutter_keys.dart';
import 'package:todolistbloc/view/view.dart';
import 'package:todolistbloc/widget/widgets.dart';
import 'package:todos_app_core/todos_app_core.dart';

class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredBloc, FilteredState>(builder: (context, state) {
      if (state is FilteredLoadInProgress) {
        return LoadingIndicator(key: ArchSampleKeys.todosLoading);
      } else if (state is FilteredLoadSuccess) {
        final todos = state.filteredTodos;
        return ListView.builder(
          key: ArchSampleKeys.todoList,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            final todo = todos[index];
            return TodoItem(
              todo: todo,
              onDismissed: (direction) {
                BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
                Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                  key: ArchSampleKeys.snackbar,
                  todo: todo,
                  onUndo: () =>
                      BlocProvider.of<TodosBloc>(context).add(TodoAdded(todo)),
                  localizations: localizations,
                ));
              },
              onTap: () async {
                final removeTodo = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return DetailScreen(id: todo.id);
                  }),
                );
                if (removeTodo != null) {
                  Scaffold.of(context).showSnackBar(DeleteTodoSnackBar(
                    key: ArchSampleKeys.snackbar,
                    todo: todo,
                    onUndo: () => BlocProvider.of<TodosBloc>(context)
                        .add(TodoAdded(todo)),
                    localizations: localizations,
                  ));
                }
              },
              onCheckboxChange: (_) {
                BlocProvider.of<TodosBloc>(context).add(
                  TodoUpdated(todo.copyWith(complete: !todo.complete)),
                );
              },
            );
          },
        );
      } else {
        return Container(key: FlutterKeys.filteredTodosEmptyContainer);
      }
    });
  }
}
