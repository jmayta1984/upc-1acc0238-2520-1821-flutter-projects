import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_event.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_state.dart';
import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final DestinationDao dao;
  FavoritesBloc({required this.dao}) : super(FavoritesState()) {
    on<GetAllFavorites>(_getAllFavorites);

    on<RemoveFavorite>(_removeFavorite);
  }

  FutureOr<void> _getAllFavorites(
    GetAllFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    List<Destination> destinations = await dao.fetchAll();
    emit(state.copyWith(destinations: destinations));
  }

  FutureOr<void> _removeFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    await dao.delete(event.id);
    List<Destination> destinations = await dao.fetchAll();
    emit(state.copyWith(destinations: destinations));
  }
}
