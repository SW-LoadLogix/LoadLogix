import 'package:flutter/material.dart';

var loginTheme = ThemeData(
  primaryColor: Color.fromARGB(255, 0x3A,0xB9,0xFF),//Colors.blue,
  colorScheme: const ColorScheme.light(primary:  Color.fromARGB(255, 0x3A,0xB9,0xFF)),//const ColorScheme.light(primary: Colors.blue),
  useMaterial3: true,
  // textTheme: const TextTheme(
  //     decorationColor: Color.fromARGB(255, 0, 0, 255),
  // ),
  /*Theme.of(context).textTheme.apply(
    // Note: The below line is required due to a current bug in Flutter:
    // https://github.com/flutter/flutter/issues/129553
      decorationColor: Color.fromARGB(255, 0, 0, 255)),
  */
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Colors.black54,
    suffixIconColor: Colors.black54,
    iconColor: Colors.black54,
    labelStyle: TextStyle(color: Colors.black54),
    hintStyle: TextStyle(color: Colors.black54),
  ),
);
