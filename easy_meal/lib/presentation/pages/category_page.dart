import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/domain/models/category.dart';
import 'package:easy_meal/presentation/blocs/meals_bloc.dart';
import 'package:easy_meal/presentation/blocs/meals_state.dart';
import 'package:easy_meal/presentation/widgets/meal_list.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: category.id,
                child: Image.network(category.posterPath, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ExpandableText(
                        category.description,
                        maxLines: 3,
                        expandText: 'Show more',
                        collapseText: 'Show less',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: BlocBuilder<MealsBloc, MealsState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case Status.loading:
                        return const Center(child: CircularProgressIndicator());
                      case Status.success:
                        return MealList(meals: state.meals);
                      case Status.failure:
                        return Center(child: Text('Error: ${state.message}'));
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
