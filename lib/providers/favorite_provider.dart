import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super(<Meal>[]); //initial data

  bool toggleMealFavoriteStats(Meal meal) {
    final isInFavorite = state.contains(meal); //state property holds your data, you can not .add or .remove
    if (isInFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
  //you must always create a new objects WE CAN NOT EDIT THE STATE
  //with where we filter a list and get a new one
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
//final mealsProvider = Provider((ref) => dummyMeals);
//Хорошо для легких штучек без всякой комплексной шелухи