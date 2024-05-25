import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(
        //kép elérése
        meal.imageUrl,
        //teljes szélesség
        width: double.infinity,
        //magasság 300 képpont
        height: 300,
        //eredeti képarány megtartása
        fit: BoxFit.cover,
      ),
    );
  }
}
