import 'package:easy_meal/data/local/meal_dao.dart';
import 'package:easy_meal/data/local/meal_entity.dart';
import 'package:easy_meal/data/remote/meal_dto.dart';
import 'package:easy_meal/data/remote/meal_service.dart';
import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealService service;
  final MealDao dao;

  const MealRepositoryImpl({required this.service, required this.dao});
  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    try {
      List<MealDto> dtos = await service.getMealsByCategory(category);
      Set<String> favoriteMealIds = await dao.fetchAllMealIds();
      return dtos
          .map(
            (dto) => dto.toDomain().copyWith(
              isFavorite: favoriteMealIds.contains(dto.id),
            ),
          )
          .toList();
    } catch (e) {
      return Future.error('$e');
    }
  }

  @override
  Future<void> toggleMealFavorite(Meal meal) {
    if (meal.isFavorite) {
      return dao.delete(meal.id);
    } else {
      final entity = MealEntity.fromDomain(meal);
      return dao.insert(entity);
    }
  }
}
