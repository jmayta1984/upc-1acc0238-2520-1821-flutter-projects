import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/review.dart';

class ReviewListState {
  final Status status;
  final List<Review> reviews;
  final String? message;

  const ReviewListState({
    this.status = Status.initial,
    this.reviews = const [],
    this.message,
  });

  ReviewListState copyWith({
    Status? status,
    List<Review>? reviews,
    String? message,
  }) {
    return ReviewListState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      message: message ?? this.message,
    );
  }
}
