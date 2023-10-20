import 'package:flutter/material.dart';
import 'package:meals_app/providers/favorite_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      filteredMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = "YourFavorites";
    }

    void setScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        await Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activeScreen,
      drawer: MainDrawer(onSelecedScreen: setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant_menu,
              ),
              label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "favorites")
        ],
      ),
    );
  }
}
