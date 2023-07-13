import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData.dark(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: const Color(0xFF0A0A0A),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFd1d1d1),
    secondary: Color(0xFFd1d1d1),
    surface: Color(0xFFd1d1d1),
    background: Color(0xFFd1d1d1),
    onPrimary: Color(0xFFd1d1d1),
    onSecondary: Color(0xFFd1d1d1),
    onSurface: Color(0xFFd1d1d1),
    onBackground: Color(0xFFd1d1d1),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: const Color(0xFFd1d1d1),
    displayColor: const Color(0xFFd1d1d1),
    decorationColor: const Color(0xFFd1d1d1),
  ),
);
