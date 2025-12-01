import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';
import 'package:easy_meal/presentation/blocs/meals_event.dart';
import 'package:easy_meal/presentation/blocs/meals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealRepository mealRepository;

  MealsBloc({required this.mealRepository}) : super(const MealsState()) {
    on<GetMealsByCategory>(_getMealsByCategory);
    on<ToggleFavoriteMeal>(_toggleFavoriteMeal);
  }

  Future<void> _getMealsByCategory(
    GetMealsByCategory event,
    Emitter<MealsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final meals = await mealRepository.getMealsByCategory(event.category);
      emit(state.copyWith(status: Status.success, meals: meals));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _toggleFavoriteMeal(
    ToggleFavoriteMeal event,
    Emitter<MealsState> emit,
  ) async {
    await mealRepository.toggleMealFavorite(event.meal);
    final updatedMeals = state.meals.map((meal) {
      if (meal.id == event.meal.id) {
        return meal.copyWith(isFavorite: !meal.isFavorite);
      }
      return meal;
    }).toList();
    emit(state.copyWith(meals: updatedMeals));
  }
}
