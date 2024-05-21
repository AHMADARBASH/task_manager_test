import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/BLoC/Auth/auth_cubit.dart';
import 'package:task_manager/BLoC/Todo/todo_cubit.dart';
import 'package:task_manager/BLoC/theme/theme_cubit.dart';
import 'package:task_manager/BLoC/theme/theme_state.dart';
import 'package:task_manager/Data/DataProviders/cached_data.dart';
import 'package:task_manager/Data/DataProviders/local_database.dart';
import 'package:task_manager/Utilities/locator.dart';
import 'package:task_manager/Utilities/routes.dart';
import 'package:task_manager/Utilities/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachedData.init();
  await DatabaseHelper.createDatabase();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  locatorSetup();
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (_) => AuthCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider<TodosCubit>(
            create: (_) => TodosCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: themes[state.theme],
          ),
        ),
      ),
    );
  }
}
