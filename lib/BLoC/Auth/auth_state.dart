abstract class AuthState {
  bool isAuth;
  AuthState({required this.isAuth});
}

class AuthInitState extends AuthState {
  AuthInitState({required super.isAuth});
}

class AuthLoadingState extends AuthState {
  AuthLoadingState() : super(isAuth: false);
}

class AuthErrorState extends AuthState {
  String errorMessage;
  AuthErrorState({required this.errorMessage}) : super(isAuth: false);
}

class AuthUpdateState extends AuthState {
  AuthUpdateState({required super.isAuth});
}

class AuthSignedUpState extends AuthState {
  AuthSignedUpState({required super.isAuth});
}
