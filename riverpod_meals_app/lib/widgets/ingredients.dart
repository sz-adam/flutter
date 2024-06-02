import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class IngredientsSection extends StatefulWidget {
  final Meal meal;

  const IngredientsSection({super.key, required this.meal});

  @override
  _IngredientsSectionState createState() => _IngredientsSectionState();
}

class _IngredientsSectionState extends State<IngredientsSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible && mounted) {
      // Az oldal betöltődésekor kezdje el megjelenni a widget
      Future.delayed(Durations.short1, () {
        setState(() {
          _isVisible = true;
        });
      });
    }
    return Column(
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        for (final ingredient in widget.meal.ingredients)
          AnimatedContainer(
            duration: const Duration(milliseconds: 900),
            curve: Easing.legacy,
            transform: Matrix4.translationValues(
              // a - jel adja hogy jobból vagy balról indul az animáció
              _isVisible ? 0 : -MediaQuery.of(context).size.width,
              0,
              0,
              //fentről lefelé vagy lentről felfelé 
           ////  transform: Matrix4.translationValues(
           ////    0,
           ////    _isVisible
           ////        ? 0
           ////        : -MediaQuery.of(context)
           ////            .size
           ////            .height, // Negatív érték: fentről lefelé indul az animáció
           ////    0,
           ////  ),
            ),
            child: Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
      ],
    );
  }
}
