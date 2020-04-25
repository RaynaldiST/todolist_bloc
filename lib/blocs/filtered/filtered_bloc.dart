import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/blocs/filtered/filtered_todo.dart';
import 'package:todolistbloc/blocs/todos/todos.dart';


class FilteredBloc extends Bloc<FilteredEvent, FilteredState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredBloc({@required this.todosBloc}) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });
  }

  @override
  // TODO: implement initialState
  FilteredState get initialState => null;

  @override
  Stream<FilteredState> mapEventToState(FilteredEvent event) {
    // TODO: implement mapEventToState
    return null;
  }

}