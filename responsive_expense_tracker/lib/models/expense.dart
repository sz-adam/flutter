import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  // A konstruktora, amely egy adott kategóriát és az ahhoz tartozó költségek listáját fogadja.
  const ExpenseBucket({required this.category, required this.expenses});

  // Egy named constructor, amely az összes költségből létrehoz egy adott kategóriához tartozó költségcsoportot.
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category) // Csak azokat a költségeket választja ki, amelyek az adott kategóriához tartoznak.
            .toList(); // A kiválasztott költségeket listává alakítja.
  
  // A kategória, amelyhez ez a költségcsoport tartozik.
  final Category category;
  // A kategóriához tartozó költségek listája.
  final List<Expense> expenses;

  // A kategóriához tartozó költségek összegét számolja ki.
  double get totalExpenses {
    double sum = 0;

    // Végigmegy a költségek listáján és összeadja az egyes költségek összegét.
    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum; // Visszaadja az összesített összeget.
  }
}
