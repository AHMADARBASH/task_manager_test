// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/BLoC/Auth/auth_cubit.dart';
import 'package:task_manager/BLoC/Auth/auth_state.dart';
import 'package:task_manager/Data/Models/user.dart';
import 'package:task_manager/Presentation/Screen/auth_screen.dart';
import 'package:task_manager/Presentation/Screen/settings_screen.dart';
import 'package:task_manager/Presentation/Widgets/confirmation_dialog.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
    required this.user,
  });

  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(user.image))),
          ),
          decoration: BoxDecoration(color: context.secondaryColor),
          accountEmail: Text(
            user.email,
            style:
                context.bodyMediumText.copyWith(color: context.tertiaryColor),
          ),
          accountName: Text(
            '${user.firstName} ${user.lastName}',
            style:
                context.bodyMediumText.copyWith(color: context.tertiaryColor),
          ),
        ),
        FadeInLeft(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuart,
          child: ListTile(
            title: Text(
              'Settings',
              style: context.bodyMediumText
                  .copyWith(color: context.secondaryColor),
            ),
            leading: Icon(
              FontAwesome.cog_alt,
              color: context.secondaryColor,
            ),
            onTap: () {
              context.pop();
              context.pushNamed(SettingsScreen.routeName);
            },
          ),
        ),
        FadeInLeft(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuart,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => ListTile(
              title: Text(
                'Signout',
                style: context.bodyMediumText
                    .copyWith(color: context.secondaryColor),
              ),
              leading: Icon(
                Icons.logout,
                color: context.secondaryColor,
              ),
              onTap: () async {
                await showConfirmationDialog(
                    context: context,
                    content: 'you are you sure to Sinout?',
                    onYesPressed: () async {
                      context.pop();
                      try {
                        await BlocProvider.of<AuthCubit>(context).signout();
                        context.pushReplacement(AuthScreen.routeName);
                      } catch (_) {}
                    },
                    onNoPressed: () {
                      context.pop();
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}
