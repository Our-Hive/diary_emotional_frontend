import 'package:flutter/material.dart';
import 'package:emotional_app/config/theme/app_color_scheme.dart';

class AppTheme {
  static ThemeData dark() => ThemeData(
        colorScheme: appColorScheme,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF1A1C27),
        ),
        tabBarTheme: const TabBarTheme(
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
          ),
        ),
      );
}
