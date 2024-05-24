import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
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
            CategoryGridItem(category: category)

            //availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        ],
      ),
    );
  }
}
