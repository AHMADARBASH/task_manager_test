// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/Utilities/context_extenstions.dart';

class CustomTextField extends StatefulWidget {
  bool isPassword;
  Widget? suffix;
  Widget? lable;
  TextInputAction? action;
  String? Function(String?) validator;
  TextEditingController? controller;
  CustomTextField({
    required this.isPassword,
    required this.validator,
    this.suffix,
    this.action,
    this.controller,
    this.lable,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword,
      textInputAction: widget.action,
      enabled: true,
      cursorColor: context.secondaryColor,
      validator: widget.validator,
      controller: widget.controller,
      style: GoogleFonts.cairo().copyWith(fontSize: 18),
      decoration: InputDecoration(
        label: widget.lable,
        labelStyle:
            context.bodyMediumText.copyWith(fontSize: 18, color: Colors.grey),
        focusColor: context.secondaryColor,
        suffixIcon: widget.suffix,
        fillColor: context.primaryColor.withOpacity(0.1),
        enabled: true,
        filled: false,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.secondaryColor,
            width: 1,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.errorColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
