import 'package:easy_meal/domain/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          category.posterPath,
          height: 120,
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        Text(category.name),
      ],
    );
  }
}
