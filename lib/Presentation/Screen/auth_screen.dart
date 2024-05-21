// ignore_for_file: use_build_context_synchronously, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_manager/BLoC/Auth/auth_cubit.dart';
import 'package:task_manager/BLoC/Auth/auth_state.dart';
import 'package:task_manager/Presentation/Widgets/custom_text_field.dart';
import 'package:task_manager/Presentation/Widgets/snackbar.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/AuthScreen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isPassword = true;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: context.secondaryColor,
            height: context.height,
          ),
          Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  color: context.secondaryColor,
                  height: 30.h,
                  child: Text(
                    "Task Manager",
                    style: context.bodyMediumText.copyWith(
                      color: context.tertiaryColor,
                      fontSize: 40.sp,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                width: context.width,
                height: 70.h,
                decoration: BoxDecoration(
                  color: context.canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'Welcome Back',
                        style: context.bodyMediumText.copyWith(fontSize: 25.sp),
                      ),
                      Text(
                        'Enter your credentials to continue',
                        style: context.bodySmallText
                            .copyWith(fontSize: 15.sp, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomTextField(
                          lable: const Text('username'),
                          controller: _usernameController,
                          action: TextInputAction.next,
                          isPassword: false,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'please enter a username';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                      StatefulBuilder(
                        builder: (context, newSetState) => CustomTextField(
                          lable: const Text('Password'),
                          controller: _passwordController,
                          action: TextInputAction.done,
                          isPassword: _isPassword,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'please enter a password';
                            }
                            return null;
                          },
                          suffix: IconButton(
                            onPressed: () {
                              newSetState(
                                () => _isPassword = !_isPassword,
                              );
                            },
                            icon: Icon(
                                _isPassword ? Icons.lock : Icons.lock_open),
                            color: context.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) =>
                                state is AuthErrorState
                                    ? showSnackbar(
                                        content: state.errorMessage,
                                        context: context)
                                    : null,
                            builder: (context, state) => ElevatedButton(
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                try {
                                  await BlocProvider.of<AuthCubit>(context)
                                      .signin({
                                    "username": _usernameController.text,
                                    "password": _passwordController.text
                                  });
                                } catch (e) {}
                              },
                              child: state is AuthLoadingState
                                  ? SpinKitThreeBounce(
                                      color: context.tertiaryColor,
                                      size: 12.sp,
                                    )
                                  : Text(
                                      'SignIn',
                                      style: context.bodyMediumText.copyWith(
                                          color: context.tertiaryColor),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
