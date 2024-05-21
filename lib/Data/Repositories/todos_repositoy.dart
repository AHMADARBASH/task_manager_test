import 'package:task_manager/Data/DataProviders/api_provider.dart';
import 'package:task_manager/Data/DataProviders/cached_data.dart';
import 'package:task_manager/Data/Models/todo.dart';
import 'package:task_manager/Data/constants/url.dart';
import 'package:task_manager/Utilities/locator.dart';

class TodosRepository {
  var apiProvider = locator.get<APIProvider>();
  var userToken = CachedData.getData(key: 'token');

  Future<Todo> addTodo({required Map<String, dynamic> body}) async {
    final url = '$baseURL/todos/add';
    final Map<String, dynamic> todo =
        await apiProvider.post(URL: url, body: body);
    return Todo.fromJson(todo);
  }

  int calculateTotalPages(int totalItems, int itemsPerPage) {
    return (totalItems / itemsPerPage).ceil();
  }

  Future<int> getUserTotalTodos({required int userId}) async {
    final url = '$baseURL/todos/user/$userId';
    final response = await apiProvider.get(URL: url);

    return calculateTotalPages(response['total'], 3);
  }

  Future<List<Todo>> getTodosByUserId(
      {required int userId, required int pageNumber}) async {
    int skip = 3 * pageNumber - 1;
    final url = '$baseURL/todos/user/$userId?limit=3&skip=$skip';
    Map<String, dynamic> respone =
        await apiProvider.get(URL: url, token: userToken);
    List<dynamic> data = respone['todos'];
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> updateTodo(
      {required int todoId, required Map<String, dynamic> body}) async {
    final url = '$baseURL/todos/$todoId';
    await apiProvider.put(URL: url, body: body);
  }

  Future<void> deleteTodo({required int todoId}) async {
    final url = '$baseURL/todos/$todoId';
    await apiProvider.delete(URL: url);
  }
}
