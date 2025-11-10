import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/destination.dart';

class FavoritesState {
  final Status status;
  final List<Destination> destinations;
  final String? message;
  
  const FavoritesState({
    this.status = Status.initial,
    this.destinations = const [],
    this.message,
  });

  FavoritesState copyWith({
    Status? status,
    List<Destination>? destinations,
    String? message,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      destinations: destinations ?? this.destinations,
      message: message ?? this.message,
    );
  } 
  
}