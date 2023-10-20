import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorite_provider.dart';
import '../models/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    bool isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Details of ${meal.title}", overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStats(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded == false
                      ? "Meal was removed"
                      : "Meal was added"),
                  duration: const Duration(seconds: 2),
                ),
              );
              //.notifier получаем доступ к классу который мы создали(FavoriteMealsNotifier)
            },
            icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: ((child, animation) => RotationTransition(
                      turns: CurvedAnimation(
                          parent: animation,
                          curve: const Interval(0.0, 1.0,
                              curve: Curves.bounceInOut)),
                      child: child,
                    )),
                child: Icon(
                  isFavorite == true ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavorite),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Hero(
            tag: meal.id,
            child: Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            "Ingredients:",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 14,
          ),
          for (final ingredient in meal.ingredients)
            Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          const SizedBox(
            height: 14,
          ),
          Text(
            "Steps:",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          for (final step in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
        ]),
      ),
    );
  }
}
