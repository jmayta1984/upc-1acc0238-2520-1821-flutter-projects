abstract class FavoriteEvent {
  const FavoriteEvent();
}

class GetAllFavorites extends FavoriteEvent {
  const GetAllFavorites();
}

class RemoveFavorite extends FavoriteEvent {
  final int id;
  const RemoveFavorite({required this.id});
}