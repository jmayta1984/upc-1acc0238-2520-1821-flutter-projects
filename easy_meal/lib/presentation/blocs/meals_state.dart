import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/domain/models/meal.dart';

class MealsState {
  final Status status;
  final List<Meal> meals;
  final String? message;

  const MealsState({
    this.status = Status.initial,
    this.meals = const [],
    this.message,
  });

  MealsState copyWith({Status? status, List<Meal>? meals, String? message}) {
    return MealsState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      message: message ?? this.message,
    );
  }
}
