import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/presentation/widgets/meal_card.dart';
import 'package:flutter/material.dart';

class MealList extends StatelessWidget {
  final List<Meal> meals;
  const MealList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return MealCard(meal: meal);
      },
    );
  }
}
