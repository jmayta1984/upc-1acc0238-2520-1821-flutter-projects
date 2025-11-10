import 'package:easy_travel/features/favorites/blocs/favorite_event.dart';
import 'package:easy_travel/features/favorites/blocs/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoritesState> {
  FavoriteBloc(): super(FavoritesState()){
    on<GetAllFavorites>((event, emit) {
      
    },);

    on<RemoveFavorite>((event, emit) {
      
    },);
  }
  
}