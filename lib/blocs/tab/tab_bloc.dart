import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolistbloc/blocs/tab/tab.dart';
import 'package:todolistbloc/preferences/preferences.dart';
import '';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}