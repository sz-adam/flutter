import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

//provider nélkül meglévő objektumot szerkeszthet memorában , provideren belül ez NEM megengedett
  bool toggleMealFavoritStatus(Meal meal) {
    // Ellenőrizzük, hogy az adott étel benne van-e a kedvencek listájában
    final mealsIsFavorite = state.contains(meal);

    if (mealsIsFavorite) {
      // Ha az étel már benne van a kedvencek között, akkor eltávolítjuk azt
      // A `where` függvény segítségével egy új listát hozunk létre, amelyből kihagyjuk az adott ételt
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // Ha az étel nincs benne a kedvencek között, akkor hozzáadjuk azt
      // Az új ételt hozzáadjuk a meglévő kedvencek listájához
      state = [...state, meal];
      return true;
    }
  }
}

//StateNotifierProvider olyan adatokhoz használják amik változhatnak
final favoritesMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
