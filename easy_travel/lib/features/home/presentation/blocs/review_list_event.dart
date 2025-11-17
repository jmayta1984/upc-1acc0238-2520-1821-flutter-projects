abstract class ReviewListEvent {
  const ReviewListEvent();
}

class GetReviews extends ReviewListEvent {
  final int id;
  const GetReviews(this.id);
}

class AddReview extends ReviewListEvent {
  final String comment;
  final int rating;
  final int id;
  final String token;
  const AddReview({
    required this.comment,
    required this.rating,
    required this.id,
    required this.token,
  });
}