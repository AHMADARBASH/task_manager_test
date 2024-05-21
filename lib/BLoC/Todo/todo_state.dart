import 'package:task_manager/Data/Models/todo.dart';

abstract class TodosState {
  List<Todo> todos;
  TodosState({required this.todos});
}

class TodosInitState extends TodosState {
  TodosInitState() : super(todos: []);
}

class TodosLoadingState extends TodosState {
  TodosLoadingState() : super(todos: []);
}

class TodosUpdateState extends TodosState {
  TodosUpdateState({required super.todos});
}

class TodosErrorState extends TodosState {
  String errorMessage;
  TodosErrorState({required this.errorMessage}) : super(todos: []);
}
