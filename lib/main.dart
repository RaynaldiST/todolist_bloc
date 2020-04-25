import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/blocs/filtered/filtered_bloc.dart';
import 'package:todolistbloc/blocs/stats/stats.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'blocs/tab/tab.dart';
import 'blocs/todos/todos.dart';
import 'localization.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    create: (context) {
      return TodosBloc(
          todosRepository: const TodosRepositoryFlutter(
        fileStorage: const FileStorage(
            '__flutter_bloc_app__', getApplicationDocumentsDirectory),
      )..add(TodoLoaded()));
    },
    child: TodosApps(),
  ));
}

class TodosApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate()
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredBloc>(
                create: (context) => FilteredBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context)
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  todosBloc: BlocProvider.of<TodosBloc>(context)
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
        ArchSampleRoutes.addTodo: (context) {
          return
        }
      },
    );
  }
}
