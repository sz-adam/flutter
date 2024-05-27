import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals});  

    final List<Meal> availableMeals;


  //NAVIGÁCIÓ
  //context nem érhető el ezért kell meghívni
  void _selectCategory(BuildContext context, Category category) {

    //dummyMeals listát szűri olyan elemekre, amelyek tartalmazzák az adott kategória azonosítóját
    final filteredMeals = availableMeals //használata a szűréshez
    //where csak azokat az elemeket tartalmazza, amelyek megfelelnek a megadott feltételnek.
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        //listává alakítjuk 
        .toList();

    //Navigáció
    Navigator.of(context).push(
      MaterialPageRoute(
        //MealsScreen-re navigál át
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,        
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(16),
        //grid elem :crossAxisCount 2 oszlop ,childAspectRatio: 3 / 2, // Szélesség / Magasság arány
        //rács elemek közötti távolság crossAxisSpacing: 20, mainAxisSpacing: 20
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          //végig megyünk a availableCategories gyüjteményen és minden egyes elemhez létrehoz egy CategoryGridItem widgetet
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              //függvény átadás
              onSelectedCategory: () {
                _selectCategory(context, category);
              },
            )

          //availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        ],
      );
    
  }
}
