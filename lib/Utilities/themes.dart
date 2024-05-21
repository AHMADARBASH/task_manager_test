// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _primaryColor = Color(0xffffc529);
const Color _secondaryColor = Color(0xfffe734c);
Color _WhiteCanvasColor = Colors.white;
Color _DarkCanvasColor = Colors.black;
const Color _errorColor = Colors.red;

Map<String, dynamic> themes = {
  'whiteTheme': ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _WhiteCanvasColor,
    canvasColor: _WhiteCanvasColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: Colors.white,
        error: _errorColor),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.bebasNeue().copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      bodyMedium:
          GoogleFonts.bebasNeue().copyWith(color: Colors.black, fontSize: 20),
      bodySmall: GoogleFonts.bebasNeue().copyWith(
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _WhiteCanvasColor,
      surfaceTintColor: Colors.transparent,
      actionsIconTheme: const IconThemeData(
        color: _secondaryColor,
      ),
      iconTheme: const IconThemeData(color: _secondaryColor),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: _WhiteCanvasColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _secondaryColor,
        extendedTextStyle: GoogleFonts.bebasNeue()
            .copyWith(color: Colors.white, fontSize: 18)),
    dialogBackgroundColor: _secondaryColor,
    iconTheme: const IconThemeData(
      color: _primaryColor,
    ),
    dialogTheme: const DialogTheme(
        backgroundColor: Colors.white, surfaceTintColor: Colors.transparent),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle:
          GoogleFonts.bebasNeue().copyWith(color: Colors.white, fontSize: 18),
      foregroundColor: Colors.white,
      backgroundColor: _secondaryColor,
    )),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _secondaryColor,
      actionTextColor: _primaryColor,
      contentTextStyle: GoogleFonts.bebasNeue().copyWith(
        color: _primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: _primaryColor,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: _primaryColor)),
    bottomAppBarTheme: const BottomAppBarTheme(color: _primaryColor),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    shadowColor: Colors.grey[400],
  ),
  'darkTheme': ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _DarkCanvasColor,
    canvasColor: _DarkCanvasColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: Colors.white,
        error: _errorColor),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.bebasNeue().copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      bodyMedium:
          GoogleFonts.bebasNeue().copyWith(color: Colors.white, fontSize: 20),
      bodySmall: GoogleFonts.bebasNeue().copyWith(
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _DarkCanvasColor,
      surfaceTintColor: Colors.transparent,
      actionsIconTheme: const IconThemeData(
        color: _secondaryColor,
      ),
      iconTheme: const IconThemeData(color: _secondaryColor),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: _DarkCanvasColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _secondaryColor,
        extendedTextStyle: GoogleFonts.bebasNeue()
            .copyWith(color: Colors.white, fontSize: 18)),
    dialogBackgroundColor: _secondaryColor,
    iconTheme: const IconThemeData(
      color: _primaryColor,
    ),
    dialogTheme: DialogTheme(
        backgroundColor: _DarkCanvasColor,
        surfaceTintColor: Colors.transparent),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle:
          GoogleFonts.bebasNeue().copyWith(color: Colors.white, fontSize: 18),
      foregroundColor: Colors.white,
      backgroundColor: _secondaryColor,
    )),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _secondaryColor,
      actionTextColor: Colors.white,
      contentTextStyle: GoogleFonts.bebasNeue().copyWith(
        color: _primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: _primaryColor,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: _primaryColor)),
    bottomAppBarTheme: const BottomAppBarTheme(color: _primaryColor),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _DarkCanvasColor,
      surfaceTintColor: Colors.transparent,
    ),
    shadowColor: _secondaryColor.withOpacity(0.3),
  ),
};
