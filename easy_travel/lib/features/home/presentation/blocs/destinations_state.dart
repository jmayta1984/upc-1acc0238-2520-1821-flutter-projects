import 'package:easy_travel/features/home/domain/destination.dart';

abstract class DestinationsState {}

class DestinationsInitialState extends DestinationsState {}

class DestinationsLoadingState extends DestinationsState {}

class DestinationsSuccesState extends DestinationsState {
  final List<Destination> destinations;
  DestinationsSuccesState({required this.destinations});
}

class DestinationsFailureState extends DestinationsState {
  final String message;
  DestinationsFailureState({required this.message});
}
