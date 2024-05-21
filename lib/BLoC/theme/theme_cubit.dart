import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/BLoC/theme/theme_state.dart';
import 'package:task_manager/Data/DataProviders/cached_data.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitState());

  void changeTheme({required String themeName}) {
    CachedData.saveData(key: 'theme', data: themeName);
    emit(ChangeThemeState(theme: themeName));
  }
}
