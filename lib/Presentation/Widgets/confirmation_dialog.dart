import 'package:flutter/material.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

Future<dynamic> showConfirmationDialog(
        {required BuildContext context,
        required void Function() onYesPressed,
        required void Function() onNoPressed,
        required String content}) =>
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        surfaceTintColor: context.tertiaryColor,
        content: Text(
          content,
          style: context.bodyMediumText,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onNoPressed,
            child: Text(
              'No',
              style: context.bodyMediumText
                  .copyWith(color: context.secondaryColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.secondaryColor,
              foregroundColor: context.secondaryColor,
            ),
            onPressed: onYesPressed,
            child: Text(
              'Yes',
              style:
                  context.bodyMediumText.copyWith(color: context.tertiaryColor),
            ),
          ),
        ],
      ),
    );
