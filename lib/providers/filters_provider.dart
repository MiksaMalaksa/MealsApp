import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  lactoseFree,
  glutenFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super(<Filter, bool>{
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter,bool> filters){
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {

  final meals = ref.watch(mealsProvider); //используем в provider несколько providers
  final currentFilters = ref.watch(filtersProvider);

  return meals.where((element) {
      if (currentFilters[Filter.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (currentFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (currentFilters[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (currentFilters[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();
});