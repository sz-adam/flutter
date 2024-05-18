import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, trave, leisure, work }

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.data,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime data;
  final Category category;
}
