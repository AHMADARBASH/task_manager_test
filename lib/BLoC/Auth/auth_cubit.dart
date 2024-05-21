import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/Data/Models/user.dart';
import 'package:task_manager/Data/Repositories/auth_repository.dart';
import 'package:task_manager/Utilities/exceptions.dart';
import 'package:task_manager/Utilities/locator.dart';
import '../Auth/auth_state.dart';
import 'dart:convert';
import '../../Data/DataProviders/cached_data.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState(isAuth: CachedData.containsKey('token')));

  Future<void> errorHandler(dynamic error) async {
    if (error is ServerException) {
      emit(AuthErrorState(errorMessage: error.toString()));
    } else if (error is SocketException) {
      emit(AuthErrorState(errorMessage: 'Connection Error'));
    } else {
      emit(AuthErrorState(errorMessage: error.toString()));
    }
  }

  final _authRepo = locator.get<AuthRepository>();

  Future<void> signin(Map<String, dynamic> credentials) async {
    try {
      emit(AuthLoadingState());
      late User user;
      final response = await _authRepo.signIn(credentials);
      user = User.fromJson(response);
      await CachedData.saveData(key: 'token', data: user.token);
      await CachedData.saveData(key: 'user', data: json.encode(user.toJson()));
      emit(AuthUpdateState(isAuth: true));
    } catch (e) {
      errorHandler(e);
    }
  }

  Future<void> signout() async {
    emit(AuthLoadingState());
    await CachedData.deleteData('token');
    await CachedData.deleteData('user');
    emit(AuthUpdateState(isAuth: false));
  }
}
