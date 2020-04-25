import 'package:equatable/equatable.dart';
import 'package:todolistbloc/preferences/preferences.dart';

abstract class FilteredState extends Equatable {
  const FilteredState();

  @override
  List<Object> get props => [];
}

class FilteredLoadInProgress extends FilteredState {}

class FilteredLoadSuccess extends FilteredState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredLoadSuccess(this.filteredTodos,
      this.activeFilter);

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() => 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter}';

}