import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/step.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoritesMealsProvider);

    final isFavorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          //explicit animációt én készítem az implicit animációt a flutter adja
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .watch(favoritesMealsProvider.notifier)
                  .toggleMealFavoritStatus(meal);
              //információs üzenet a törlésre
              ScaffoldMessenger.of(context).clearSnackBars();
              //információs üzenet a hozzáadásra
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      wasAdded ? 'Meal addad as a favorite' : 'Meal renoved')));
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                //kép elérése
                meal.imageUrl,
                //teljes szélesség
                width: double.infinity,
                //magasság 300 képpont
                height: 300,
                //eredeti képarány megtartása
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            //vagy mapp függvénnyel
            for (final ingedient in meal.ingredients)
              Text(
                ingedient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            const SizedBox(height: 24),
             StepsSection(meal: meal, isFavorite: isFavorite),
         ///  AnimatedOpacity(
         ///    opacity: _visible ? 0.0 : 1.0,
         ///duration: const Duration(milliseconds: 1000),
         ///
         ///    
         ///    child: Text(
         ///      'Steps',
         ///      style: Theme.of(context).textTheme.titleLarge!.copyWith(
         ///          color: Theme.of(context).colorScheme.primary,
         ///          fontWeight: FontWeight.bold),
         ///    ),
         ///  ),
         ///  const SizedBox(height: 16),
         ///  for (final step in meal.steps)
         ///    Padding(
         ///      padding:
         ///          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
         ///      child: Text(
         ///        step,
         ///        textAlign: TextAlign.center,
         ///        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
         ///            color: Theme.of(context).colorScheme.onBackground),
         ///      ),
          //    ),
          ],
        ),
      ),
    );
  }
}
