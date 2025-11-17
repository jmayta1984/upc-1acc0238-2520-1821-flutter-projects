import 'package:easy_travel/features/home/data/destination_dao.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/domain/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final DestinationDao dao;
  final DestinationService service;

  const DestinationRepositoryImpl({required this.dao, required this.service});

  @override
  Future<List<Destination>> getDestinationsByCategory(String category) {
    return service.getDestinations(category);
  }

  @override
  Future<List<Destination>> getFavoriteDestinations() {
    return dao.fetchAll();
  }

  @override
  Future<Set<int>> getFavoriteIds() async {
    final List<Destination> favorites = await dao.fetchAll();
    return favorites.map((destination) => destination.id).toSet();
  }

  @override
  Future<void> toggleFavorite(Destination destination) async {
    final bool isFavorite = await dao.isFavorite(destination.id);

    isFavorite ? await dao.delete(destination.id) : dao.insert(destination);
  }
}
