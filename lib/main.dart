import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:todolistbloc/blocs/tab/tab.dart';
import 'package:todolistbloc/localization.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    create: (context) {
      return TodosBloc(
          todosRepository: const TodosRepositoryFlutter(
        fileStorage: const FileStorage(
            '__flutter_bloc_app__', getApplicationDocumentsDirectory),
      )..add(TodosLoaded()));
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
              BlocProvider<FilteredTodoBloc>(

              ),
            ],
          );
        }
      },
    );
  }
}


