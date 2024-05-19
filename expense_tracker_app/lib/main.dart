import 'package:expense_tracker_app/widget/expense.dart';
import 'package:flutter/material.dart';

var kColorSheme =
    ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 96, 59, 181));


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorSheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSheme.onPrimaryContainer,
          foregroundColor: kColorSheme.primaryContainer
        )
      ),
      home: const Expenses(),
    ),
  );
}
