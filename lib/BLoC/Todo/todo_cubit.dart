import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/BLoC/Todo/todo_state.dart';
import 'package:task_manager/Data/DataProviders/local_database.dart';
import 'package:task_manager/Data/Models/todo.dart';
import 'package:task_manager/Data/Repositories/todos_repositoy.dart';
import 'package:task_manager/Utilities/exceptions.dart';
import 'package:task_manager/Utilities/locator.dart';

enum Operation { initial, previous, next }

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosInitState());
  int currentPage = 0;
  int todosLimit = 0;

  Future<void> errorHandler(dynamic error) async {
    if (error is ServerException) {
      emit(TodosErrorState(errorMessage: error.toString()));
    } else if (error is SocketException) {
      final localTodos =
          await DatabaseHelper.getDatafromDatabase(tableName: 'todo');
      if (localTodos.isNotEmpty) {
        final data = localTodos.map((e) => Todo.fromLoaclJson(e)).toList();
        emit(TodosUpdateState(todos: data));
      } else {
        emit(TodosErrorState(
            errorMessage: 'Connection Error. No data available offline'));
      }
    } else {
      emit(TodosErrorState(errorMessage: error.toString()));
    }
  }

  final _todosRepo = locator.get<TodosRepository>();

  Future<void> getTodosByUserId({
    required int userId,
    required Operation operaiton,
  }) async {
    try {
      emit(TodosLoadingState());
      todosLimit = await _todosRepo.getUserTotalTodos(userId: userId);
      late List<Todo> todos;
      if (operaiton == Operation.initial) {
        currentPage = 0;
        todos = await _todosRepo.getTodosByUserId(
            userId: userId, pageNumber: currentPage);
      } else if (operaiton == Operation.next) {
        currentPage++;
        todos = await _todosRepo.getTodosByUserId(
            userId: userId, pageNumber: currentPage);
      } else {
        currentPage = currentPage > 1 ? currentPage -= 1 : 0;
        todos = await _todosRepo.getTodosByUserId(
            userId: userId, pageNumber: currentPage);
      }
      for (var e in todos) {
        DatabaseHelper.deletefromDatabase(id: e.id, tableName: 'todo');
        DatabaseHelper.insertIntoDatabase(
            tableName: 'todo', data: e.toLocalJson());
      }

      emit(TodosUpdateState(todos: todos));
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> addTodo({required Map<String, dynamic> body}) async {
    try {
      final todo = await _todosRepo.addTodo(body: body);
      DatabaseHelper.insertIntoDatabase(
          tableName: 'todo', data: todo.toLocalJson());
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> updateTodo({required int todoId, required Todo todo}) async {
    try {
      await _todosRepo
          .updateTodo(todoId: todoId, body: {"completed": todo.completed});
      var updatedTodo = todo.toLocalJson();
      updatedTodo['completed'] == 1
          ? updatedTodo['completed'] = 0
          : updatedTodo['completed'] = 1;
      await DatabaseHelper.updateItem(data: updatedTodo, tableName: 'todo');
    } catch (e) {
      if (e is ServerException) {
        emit(TodosErrorState(errorMessage: e.toString()));
      } else if (e is SocketException) {
        var localTodos =
            await DatabaseHelper.getDatafromDatabase(tableName: 'todo');
        if (localTodos.isNotEmpty) {
          var localTodo = localTodos.firstWhere(
            (element) => element['id'] == todoId,
          );
          var test = Map.of(localTodo);
          test['completed'] == 1
              ? test['completed'] = 0
              : test['completed'] = 1;

          await DatabaseHelper.updateItem(
            tableName: 'todo',
            data: test,
          );
          var data =
              await DatabaseHelper.getDatafromDatabase(tableName: 'todo');
          final updatedLocalTodos =
              data.map((e) => Todo.fromLoaclJson(e)).toList();
          emit(TodosUpdateState(todos: updatedLocalTodos));
        } else {
          emit(TodosErrorState(
              errorMessage: 'Connection Error. No data available offline'));
        }
      } else {
        emit(TodosErrorState(errorMessage: e.toString()));
      }
    }
  }

  Future<void> deleteTodo({required int todoId}) async {
    try {
      await _todosRepo.deleteTodo(
        todoId: todoId,
      );
      await DatabaseHelper.deletefromDatabase(id: todoId, tableName: 'todo');
    } catch (e) {
      if (e is ServerException) {
        emit(TodosErrorState(errorMessage: e.toString()));
      } else if (e is SocketException) {
        await DatabaseHelper.deletefromDatabase(id: todoId, tableName: 'todo');
      } else {
        emit(TodosErrorState(errorMessage: e.toString()));
      }
    }
  }
}
