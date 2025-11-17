import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/domain/destination_repository.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/models/destination_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationRepository repository;
  HomeBloc({required this.repository}) : super(HomeState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);

    on<ToggleFavorite>(_toggleFavorite);
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    repository.toggleFavorite(event.destination);

    final favoriteIds = await repository.getFavoriteIds();

    final List<DestinationUi> destinations = state.destinations.map((item) {
      return DestinationUi(
        destination: item.destination,
        isFavorite: favoriteIds.contains(item.destination.id),
      );
    }).toList();
    emit(state.copyWith(destinations: destinations));
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter<HomeState> emit,
  ) async {
    if (state.selectedCategory == event.category &&
        state.destinations.isNotEmpty) {
      return;
    }
    emit(
      state.copyWith(status: Status.loading, selectedCategory: event.category),
    );

    try {
      final List<Destination> destinations = await repository
          .getDestinationsByCategory(event.category);
      final Set<int> favoriteIds = await repository.getFavoriteIds();

      List<DestinationUi> destinationsUi = destinations.map((e) {
        return DestinationUi(destination: e, isFavorite: favoriteIds.contains(e.id));
      }).toList();
      emit(
        state.copyWith(status: Status.success, destinations: destinationsUi),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
