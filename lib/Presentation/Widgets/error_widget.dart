import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final void Function() onPressed;
  final Color? reloadColor;
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
    this.reloadColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/svgs/Error.svg',
            height: 20.h,
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(errorMessage),
        SizedBox(
          height: 5.h,
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.refresh,
            color: reloadColor ?? context.secondaryColor,
          ),
        )
      ],
    );
  }
}
