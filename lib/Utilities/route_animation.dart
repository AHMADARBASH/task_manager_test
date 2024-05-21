// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SizeTransitionAnimation extends PageRouteBuilder {
  final Widget page;
  SizeTransitionAnimation({required this.page})
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.fastLinearToSlowEaseIn,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
        );
}

CustomTransitionPage<dynamic> RightSlideTranstionAnimation(
    {required Widget child}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
        parent: animation,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn,
      );
      final Animation<Offset> offset = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0, 0.0),
      ).animate(animation);
      return SlideTransition(
        position: offset,
        child: child,
      );
    },
  );
}

CustomTransitionPage<dynamic> BottomSlideTranstionAnimation(
    {required Widget child}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(
        parent: animation,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn,
      );
      final Animation<Offset> offset = Tween<Offset>(
        begin: const Offset(0, 1),
        end: const Offset(0, 0),
      ).animate(animation);
      return SlideTransition(
        position: offset,
        child: child,
      );
    },
  );
}
