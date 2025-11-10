import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:easy_travel/features/home/presentation/models/destination_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationService service;
  final DestinationDao dao;
  HomeBloc({required this.service, required this.dao}) : super(HomeState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);

    on<ToggleFavorite>(_toggleFavorite);
  }

  FutureOr<void> _toggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) async {
    bool isFavorite = await dao.isFavorite(event.destination.id);
    if (isFavorite) {
      dao.insert(event.destination);
    } else {
      dao.delete(event.destination.id);
    }
    emit(state.copyWith());
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
      final List<Destination> destinations = await service.getDestinations(
        event.category,
      );

      List<DestinationUi> destinationsUi = destinations.map((e) {
        return DestinationUi(destination: e, isFavorite: false);
      }).toList();
      emit(
        state.copyWith(status: Status.success, destinations: destinationsUi),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
