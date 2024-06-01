import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class StepsSection extends StatefulWidget {
  const StepsSection({
    super.key,
    required this.meal,
    required this.isFavorite,
  }) ;

  final Meal meal;
  final bool isFavorite;

  @override
  _StepsSectionState createState() => _StepsSectionState();
}

class _StepsSectionState extends State<StepsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    // Ha a widget még nincs beillesztve a fastruktúrába, akkor ne állítsuk be az _visible változót
    if (!_visible && mounted) {
      // Az oldal betöltődésekor kezdje el megjelenni a widget
      Future.delayed(Duration.zero, () {
        setState(() {
          _visible = true;
        });
      });
    }

    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(seconds: 5),
      child: Column(
        children: [
          Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          
          const SizedBox(height: 16),
          for (final step in widget.meal.steps)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
        ],
      ),
    );
  }
}
