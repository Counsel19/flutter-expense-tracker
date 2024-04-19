import "package:flutter/material.dart";
// import "package:flutter/services.dart";
import "package:expense_tracker/widgets/expenses.dart";

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 95, 59, 181));

var kDartColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((func) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDartColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDartColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: kColorScheme.onSecondaryContainer),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
  // });
}
