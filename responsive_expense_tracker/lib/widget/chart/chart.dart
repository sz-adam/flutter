import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widget/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  // Az expenses listából kategorizált költségcsoportokat hoz létre.
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  // Megkeresi a maximális költséget a csoportok közül, amely az oszlopdiagram skálázásához szükséges.
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; // Ellenőrzi, hogy sötét módban van-e a rendszer.

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Lekerekített sarkok.
        gradient: LinearGradient(
          // Gradiens háttér, amely fentről lefelé áttetszővé válik.
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment
                  .end, // Az oszlopokat az alsó szélhez igazítja.
              children: [
                for (final bucket
                    in buckets) // Minden költségcsoporthoz létrehoz egy ChartBar widgetet.
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses /
                            maxTotalExpense, // Az oszlop kitöltése arányosan a maximális költséghez képest.
                  )
              ],
            ),
          ),
          const SizedBox(
              height: 12), // Távolság az oszlopok és az ikonok között.
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded( // Minden költségcsoporthoz egy ikont jelenít meg, arányosan elosztva.
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category], // Kategóriaikon megjelenítése.
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.secondary // Sötét módban másodlagos színt használ.
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7), // Világos módban az elsődleges színt használja.
                          ),
                        ),                       
                        Text(
                          '\$${bucket.totalExpenses.toStringAsFixed(2)}', // összeg 2 tizedejegyig való megjelenítés plusz a $jel 
                          style: TextStyle(
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.secondary // Sötét módban másodlagos színt használ.
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
