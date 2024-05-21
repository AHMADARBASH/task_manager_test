import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

Future<dynamic> showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required void Function() onPressed,
}) async {
  showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
            surfaceTintColor: context.tertiaryColor,
            title: Text(
              title,
              style: context.bodyMediumText
                  .copyWith(color: context.secondaryColor),
            ),
            content: Text(content),
            actions: [
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Ok'),
              )
            ],
          ));
}
