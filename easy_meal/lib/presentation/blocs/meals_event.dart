import 'package:easy_meal/domain/models/meal.dart';

abstract class MealsEvent {
  const MealsEvent();
}

class GetMealsByCategory extends MealsEvent {
  final String category;
  const GetMealsByCategory({required this.category});
}

class ToggleFavoriteMeal extends MealsEvent {
  final Meal meal;
  const ToggleFavoriteMeal({required this.meal});
}
