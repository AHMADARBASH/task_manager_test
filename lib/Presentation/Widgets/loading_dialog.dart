// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_manager/Presentation/Widgets/loading_widget.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

Future<dynamic> showLoadingDialog({required BuildContext context}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: context.tertiaryColor,
      content: Container(
        width: 100,
        height: 100,
        child: const LoadingWidget(),
      ),
    ),
  );
}
