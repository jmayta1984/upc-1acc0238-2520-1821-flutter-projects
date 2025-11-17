class ReviewRequest {
  final int id;
  final String comment;
  final int rating;

  const ReviewRequest({
    required this.id,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toJson(){
    return {
      'destinationId': id,
      'comment': comment,
      'rating': rating
    };
  }
}
