import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widget/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerLeft,
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child:const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        secondaryBackground: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child:const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
