import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});


  //NAVIGÁCIÓ
  //context nem érhető el ezért kell meghívni
  void _selectCategory(BuildContext context) {
    //Navigáció
    Navigator.of(context).push(
      MaterialPageRoute(
        //MealsScreen-re navigál át 
        builder: (ctx) =>const MealsScreen(
          title: 'Some title',
          meals: [],
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your Category'),
      ),
      body: GridView(
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
                _selectCategory(context);
              },
            )

          //availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        ],
      ),
    );
  }
}
