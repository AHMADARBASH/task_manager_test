import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/BLoC/Todo/todo_cubit.dart';
import 'package:task_manager/BLoC/Todo/todo_state.dart';
import 'package:task_manager/Data/DataProviders/cached_data.dart';
import 'package:task_manager/Data/Models/user.dart';
import 'package:task_manager/Presentation/Widgets/confirmation_dialog.dart';
import 'package:task_manager/Presentation/Widgets/custom_dialog.dart';
import 'package:task_manager/Presentation/Widgets/custom_text_field.dart';
import 'package:task_manager/Presentation/Widgets/error_widget.dart';
import 'package:task_manager/Presentation/Widgets/grey_holder.dart';
import 'package:task_manager/Presentation/Widgets/loading_dialog.dart';
import 'package:task_manager/Presentation/Widgets/loading_widget.dart';
import 'package:task_manager/Presentation/Widgets/snackbar.dart';
import 'package:task_manager/Presentation/Widgets/user_drawer.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class UserHomeScreen extends StatefulWidget {
  static const String routeName = '/UserHomeScreen';
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late User user;

  @override
  void initState() {
    user = User.fromJson(json.decode(CachedData.getData(key: 'user')!));
    BlocProvider.of<TodosCubit>(context)
        .getTodosByUserId(userId: user.id, operaiton: Operation.initial);
    super.initState();
  }

  TextEditingController _titleController = TextEditingController();
  bool _Completed = false;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int currentPage = context.watch<TodosCubit>().currentPage;
    int userLimit = context.watch<TodosCubit>().todosLimit;
    // print(user.token);
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          '',
          style: context.bodyMediumText.copyWith(fontSize: 18.sp),
        ),
      ),
      drawer: Drawer(
        child: UserDrawer(
          user: user,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 40.h,
                width: context.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const GreyHolder(width: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomTextField(
                          lable: Text('Task Title'),
                          action: TextInputAction.done,
                          controller: _titleController,
                          isPassword: false,
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'please enter the task title';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Text("Completed"),
                      StatefulBuilder(
                        builder: (context, setState) => Switch(
                          activeColor: context.secondaryColor,
                          inactiveTrackColor: Colors.grey,
                          value: _Completed,
                          onChanged: (value) {
                            setState(() {
                              _Completed = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            showConfirmationDialog(
                                context: context,
                                content:
                                    "are you sure to add  ${_titleController.text} ?",
                                onNoPressed: () {
                                  context.pop();
                                },
                                onYesPressed: () async {
                                  try {
                                    context.pop();
                                    showLoadingDialog(context: context);
                                    await BlocProvider.of<TodosCubit>(context)
                                        .addTodo(body: {
                                      "todo": _titleController.text,
                                      "completed": _Completed,
                                      "userId": user.id,
                                    });
                                    await BlocProvider.of<TodosCubit>(context)
                                        .getTodosByUserId(
                                            userId: user.id,
                                            operaiton: Operation.next);
                                    context.pop();
                                    context.pop();
                                    showSnackbar(
                                        context: context,
                                        content: "Task Added Successfully");
                                  } catch (e) {
                                    showCustomDialog(
                                        context: context,
                                        title: 'Error',
                                        content:
                                            "an error occured \n ${e.toString()}",
                                        onPressed: () {
                                          context.pop();
                                        });
                                  }
                                });
                          },
                          child: Text('Add'))
                    ],
                  ),
                ),
              ),
            ),
          ).then(
            (value) {
              _Completed = false;

              _titleController.clear();
            },
          );
        },
        child: Icon(Entypo.list_add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<TodosCubit, TodosState>(
              builder: (context, state) => state is TodosLoadingState
                  ? Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        LoadingWidget(),
                      ],
                    )
                  : state is TodosErrorState
                      ? CustomErrorWidget(
                          errorMessage: state.errorMessage,
                          onPressed: () {
                            BlocProvider.of<TodosCubit>(context)
                                .getTodosByUserId(
                                    userId: user.id,
                                    operaiton: Operation.initial);
                          })
                      : Column(
                          children: [
                            SizedBox(
                              height: 40.h,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  BlocProvider.of<TodosCubit>(context)
                                      .currentPage = 0;
                                  BlocProvider.of<TodosCubit>(context)
                                      .getTodosByUserId(
                                          userId: user.id,
                                          operaiton: Operation.initial);
                                },
                                color: context.secondaryColor,
                                child: ListView.builder(
                                  itemCount: state.todos.length,
                                  itemBuilder: (context, index) => Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(state.todos[index].id.toString()),
                                    background: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: context.errorColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.only(right: 20),
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.delete,
                                        color: context.tertiaryColor,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      await showConfirmationDialog(
                                          context: context,
                                          content:
                                              'are you sure to delete this item?',
                                          onYesPressed: () async {
                                            showLoadingDialog(context: context);
                                            await BlocProvider.of<TodosCubit>(
                                                    context)
                                                .deleteTodo(
                                                    todoId:
                                                        state.todos[index].id);
                                            setState(() {
                                              state.todos
                                                  .remove(state.todos[index]);
                                            });

                                            context.pop();
                                            context.pop();
                                            showCustomDialog(
                                                context: context,
                                                title: 'Deleted',
                                                content:
                                                    'Item Deleted Successfully',
                                                onPressed: () {
                                                  context.pop();
                                                });
                                          },
                                          onNoPressed: () {
                                            context.pop();
                                          });
                                      return null;
                                    },
                                    child: Card(
                                      color:
                                          context.canvasColor.withOpacity(0.9),
                                      surfaceTintColor:
                                          state.todos[index].completed
                                              ? Colors.green.withOpacity(0.1)
                                              : context.secondaryColor
                                                  .withOpacity(0.1),
                                      shadowColor: state.todos[index].completed
                                          ? Colors.green
                                          : context.secondaryColor,
                                      child: ListTile(
                                        leading: state.todos[index].completed
                                            ? const Icon(
                                                Icons
                                                    .check_circle_outline_outlined,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.error_outline,
                                                color: context.secondaryColor,
                                              ),
                                        title: Text(
                                          state.todos[index].todo,
                                          style: context.bodyMediumText,
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.edit_calendar_outlined,
                                            color: state.todos[index].completed
                                                ? Colors.green
                                                : context.secondaryColor,
                                          ),
                                          onPressed: () async {
                                            try {
                                              showLoadingDialog(
                                                  context: context);
                                              await BlocProvider.of<TodosCubit>(
                                                      context)
                                                  .updateTodo(
                                                      todoId:
                                                          state.todos[index].id,
                                                      todo: state.todos[index]);
                                              setState(() {
                                                state.todos[index].completed =
                                                    !state
                                                        .todos[index].completed;
                                                context.pop();
                                              });
                                            } catch (e) {
                                              showCustomDialog(
                                                  context: context,
                                                  title: 'error',
                                                  content:
                                                      'an error occured \n $e',
                                                  onPressed: () {
                                                    context.pop();
                                                  });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (currentPage <= 0) {
                                      return;
                                    }
                                    BlocProvider.of<TodosCubit>(context)
                                        .getTodosByUserId(
                                            userId: user.id,
                                            operaiton: Operation.previous);
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new),
                                  color: currentPage <= 0
                                      ? Colors.grey
                                      : context.secondaryColor,
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (currentPage + 1 == userLimit) {
                                      return;
                                    }
                                    BlocProvider.of<TodosCubit>(context)
                                        .getTodosByUserId(
                                            userId: user.id,
                                            operaiton: Operation.next);
                                  },
                                  icon: Icon(Icons.arrow_forward_ios),
                                  color: currentPage + 1 == userLimit
                                      ? Colors.grey
                                      : context.secondaryColor,
                                )
                              ],
                            )
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
