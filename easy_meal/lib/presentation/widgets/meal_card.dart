import 'package:easy_meal/domain/models/meal.dart';
import 'package:easy_meal/presentation/blocs/meals_bloc.dart';
import 'package:easy_meal/presentation/blocs/meals_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 8,
        children: [
          ClipOval(
            child: Image.network(
              meal.posterPath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(child: Text(meal.name)),
          IconButton(
            onPressed: () =>
                context.read<MealsBloc>().add(ToggleFavoriteMeal(meal: meal)),
            icon: Icon(meal.isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
