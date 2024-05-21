import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

void showSnackbar(
    {required BuildContext context,
    required String content,
    SnackBarAction? action}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: context.bodyMediumText.copyWith(color: context.tertiaryColor),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.secondaryColor,
      action: action,
    ),
  );
}
