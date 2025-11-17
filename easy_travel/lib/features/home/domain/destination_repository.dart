import 'package:easy_travel/features/home/domain/destination.dart';

abstract class DestinationRepository {

  Future<List<Destination>> getDestinationsByCategory(String category);

  Future<List<Destination>> getFavoriteDestinations();

  Future<void> toggleFavorite(Destination destination);

  Future<Set<int>> getFavoriteIds();
}