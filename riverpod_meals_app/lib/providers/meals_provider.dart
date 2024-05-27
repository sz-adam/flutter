import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

//dummy meals Provider
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
