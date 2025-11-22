import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/data/review_request.dart';
import 'package:easy_travel/features/home/data/review_service.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/review_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  final ReviewService service;
  ReviewListBloc({required this.service}) : super(const ReviewListState()) {
    on<GetReviews>(_onGetReviews);
    on<SubmitReview>(_onSubmitReview);
  }

  Future<void> _onGetReviews(
    GetReviews event,
    Emitter<ReviewListState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final reviews = await service.getReviewsById(event.id);

      emit(state.copyWith(status: Status.success, reviews: reviews));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _onSubmitReview(
    SubmitReview event,
    Emitter<ReviewListState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ReviewRequest(
        id: event.id,
        comment: event.comment,
        rating: event.rating,
      );
      await service.submitReview(request);

      final reviews = await service.getReviewsById(event.id);

      emit(state.copyWith(status: Status.success, reviews: reviews));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
