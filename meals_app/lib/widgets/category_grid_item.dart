import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

//category import
  final Category category;

  @override
  Widget build(BuildContext context) {
    /// InkWell(add visszajelzést) vagy  GestureDetector(nem ad visszajelezést) widgettel coppintathato
    return InkWell(
      onTap: () {},
      //szinátmenet + radius rá 
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
            //szinátmenet
            gradient: LinearGradient(
                colors: [
              //category szinei
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)
            ],
                //kezdet
                begin: Alignment.topLeft,
                //vég
                end: Alignment.bottomRight)),
        //Theme.of(context).textTheme.titleLarge -> main.dart-ban meghatározott téma
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                //állítsa be a (main.dart-ban meghatározott szin ) contextus szinsémájának értékére flutter következteti ki
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
