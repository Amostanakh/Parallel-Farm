import 'package:flutter/material.dart';

enum ThemeOptions {
  Light,
  Dark,
}

enum DarkThemeOptions {
  Dim,
  LightsOut,
}

final themeOptions = {
  ThemeOptions.Light: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,

    backgroundColor: Color(0xFFE6ECF0),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  DarkThemeOptions.Dim: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,

    backgroundColor: Color(0xFF10171E),
    scaffoldBackgroundColor: Color(0xFF15202B),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  DarkThemeOptions.LightsOut: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,

    backgroundColor: Color(0xFF202327),
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};