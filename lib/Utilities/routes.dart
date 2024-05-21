import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/BLoC/Auth/auth_cubit.dart';
import 'package:task_manager/BLoC/Auth/auth_state.dart';
import 'package:task_manager/Presentation/Screen/auth_screen.dart';
import 'package:task_manager/Presentation/Screen/settings_screen.dart';
import 'package:task_manager/Presentation/Screen/user_home_screen.dart';
import 'package:task_manager/Utilities/route_animation.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocBuilder<AuthCubit, AuthState>(
        builder: (authContext, authState) =>
            authState.isAuth ? const UserHomeScreen() : const AuthScreen(),
      ),
    ),
    GoRoute(
      path: SettingsScreen.routeName,
      name: SettingsScreen.routeName,
      pageBuilder: (context, state) =>
          RightSlideTranstionAnimation(child: const SettingsScreen()),
    ),
  ],
);
