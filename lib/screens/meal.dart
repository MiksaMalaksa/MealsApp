import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectedMealItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return MealDetailsScreen(meal: meal);
    }));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: meals[index],
            onSelectedMealItem: (context, meal) =>
                selectedMealItem(context, meal),
          );
        });

    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Unfortunately...nothing here!",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Select something different",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
