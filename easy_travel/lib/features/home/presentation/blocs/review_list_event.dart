abstract class ReviewListEvent {
  const ReviewListEvent();
}

class GetReviews extends ReviewListEvent {
  final int id;
  const GetReviews(this.id);
}

class SubmitReview extends ReviewListEvent {
  final String comment;
  final int rating;
  final int id;
  const SubmitReview({
    required this.comment,
    required this.rating,
    required this.id,
  });
}
