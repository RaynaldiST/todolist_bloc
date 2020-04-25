import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/blocs/todos/todos.dart';
import 'package:todolistbloc/preferences/models/todo.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({@required this.todosRepository});

  @override
  TodosState get initialState => TodosLoadInProgress();

  @override
  Stream<TodosState> mapEventToState(TodoEvent event) {
    if (event is TodoLoaded) {
      _mapTodosLoadedToState();
    } else if (event is TodoAdded) {
      _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    final todos = await this.todosRepository.loadTodos();
    yield TodosLoadSuccess(
      todos.map(Todo.fromEntity).toList(),
    );
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccess) {
      final List<Todo> addedTodos = List.from((state as TodosLoadSuccess).todos)
        ..add(event.todo);
      yield TodosLoadSuccess(addedTodos);
      _saveTodos(addedTodos);
    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadSuccess) {
      final List<Todo> updatedTodos =
          (state as TodosLoadSuccess).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield TodosLoadSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadSuccess) {
      final deletedTodos = (state as TodosLoadSuccess)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoadSuccess(deletedTodos);
      _saveTodos(deletedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccess) {
      final allComplete =
          (state as TodosLoadSuccess).todos.every((todo) => todo.complete);

      final List<Todo> stateList = (state as TodosLoadSuccess)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoadSuccess(stateList);
      _saveTodos(stateList);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccess) {
      final List<Todo> completeState = (state as TodosLoadSuccess)
          .todos
          .where((todo) => !todo.complete)
          .toList();
      yield TodosLoadSuccess(completeState);
      _saveTodos(completeState);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
