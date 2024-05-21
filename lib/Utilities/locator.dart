import 'package:get_it/get_it.dart';
import 'package:task_manager/Data/DataProviders/api_provider.dart';
import 'package:task_manager/Data/Repositories/auth_repository.dart';
import 'package:task_manager/Data/Repositories/todos_repositoy.dart';

final locator = GetIt.instance;

void locatorSetup() {
  locator.registerLazySingleton(() => APIProvider());
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => TodosRepository());
}
