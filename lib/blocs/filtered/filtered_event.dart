import 'package:equatable/equatable.dart';
import 'package:todolistbloc/preferences/preferences.dart';

abstract class FilteredEvent extends Equatable {
  const FilteredEvent();
}

class FilteredUpdated extends FilteredEvent {
  final VisibilityFilter filter;

  const FilteredUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilteredUpdated { filter: $filter }';
}

class TodosUpdated extends FilteredEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosUpdated { todos: $todos }';
}