import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.meals,
      this.title,
    });

  //átadott adatok tipusának meghatározása
  final String? title;
  final List<Meal> meals;


  //Navigation mealsDetails
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealDetails(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //ListView görgethető listanézet
    //Theme.of(context).colorScheme main.dartban meghatározott szin flutter által generált átmenete
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize
            .min, //A Column csak annyi helyet foglal, amennyi szükséges
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );

    // Ellenőrzi, hogy a meals lista üres-e
    if (meals.isNotEmpty) {
      // Ha nem üres, akkor a content-et egy Center widgetre cseréli
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
