import 'package:easy_travel/features/favorites/blocs/favorites_bloc.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_event.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) => ListView.builder(
        itemCount: state.destinations.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.read<FavoritesBloc>().add(RemoveFavorite(id: state.destinations[index].id)),
          child: Text(state.destinations[index].title)),
      ),
    );
  }
}
