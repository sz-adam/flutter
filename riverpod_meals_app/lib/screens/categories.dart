import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

//az animációkhoz StatefulWidget-re van szükség
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override //animáció meghívása
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
  }

  @override //ha lefutott az animáció törlődik a memóriából
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //NAVIGÁCIÓ
  void _selectCategory(BuildContext context, Category category) {
    //dummyMeals listát szűri olyan elemekre, amelyek tartalmazzák az adott kategória azonosítóját
    final filteredMeals = widget.availableMeals //használata a szűréshez
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
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
        ),
        //saját animáció beállítás
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
