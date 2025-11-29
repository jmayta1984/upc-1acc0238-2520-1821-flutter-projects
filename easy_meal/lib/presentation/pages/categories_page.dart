import 'package:easy_meal/core/enums/status.dart';
import 'package:easy_meal/presentation/blocs/categories_bloc.dart';
import 'package:easy_meal/presentation/blocs/categories_state.dart';
import 'package:easy_meal/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.failure:
              return Center(child: Text(state.message ?? 'Unknown error'));
            case Status.success:
              return CategoriesList(categories: state.categories);
            default:
              return const Center(child: SizedBox.shrink());
          }
        },
      ),
    );
  }
}
