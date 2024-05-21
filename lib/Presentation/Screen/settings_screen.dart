import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/BLoC/theme/theme_cubit.dart';
import 'package:task_manager/Data/DataProviders/cached_data.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/SettingsScreen';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = CachedData.getData(key: 'theme') == 'darkTheme';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: context.bodyMediumText,
        ),
      ),
      body: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuart,
            child: ListTile(
              leading: Icon(
                Icons.brightness_4_rounded,
                color: context.secondaryColor,
              ),
              title: Text('Dark Theme', style: context.bodyMediumText),
              trailing: Switch(
                onChanged: (value) {
                  if (value == true) {
                    BlocProvider.of<ThemeCubit>(context).changeTheme(
                      themeName: 'darkTheme',
                    );
                    _isDarkTheme = value;
                    setState(() {});
                  } else {
                    BlocProvider.of<ThemeCubit>(context)
                        .changeTheme(themeName: 'whiteTheme');
                    _isDarkTheme = false;
                  }
                },
                value: _isDarkTheme,
                activeColor: context.secondaryColor,
                inactiveTrackColor: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
