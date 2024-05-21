import 'package:flutter/material.dart';

extension BuildContextEntension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
  Color get canvasColor => Theme.of(this).canvasColor;
  Color get errorColor => Theme.of(this).colorScheme.error;
  TextStyle get bodyMediumText => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmallText => Theme.of(this).textTheme.bodySmall!;
}
