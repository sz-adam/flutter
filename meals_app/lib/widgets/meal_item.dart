import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      //hogyan kell levágni ha kilog a szülő elemből
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {},
        //Stack widget -> widgeteket lehet egymásra pakolni
        child: Stack(
          children: [
            FadeInImage(
                //Helykitöltő widget, placeholder amig a kép nem töltödik le addig mutatja
              placeholder: MemoryImage(kTransparentImage),
             // kép betöltése
              image: NetworkImage(meal.imageUrl),
              //kép soha ne torzuljon
              fit: BoxFit.cover,
              height: 200,
              //teljes szélleség
              width: double.infinity,
            ),
            Positioned(
              //ugyanaz mint css-ben a postion relative absolute
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      //maxLines a sorok számát korlátoza
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ... ,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
