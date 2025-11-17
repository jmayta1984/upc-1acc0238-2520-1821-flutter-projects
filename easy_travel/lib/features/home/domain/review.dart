import 'package:easy_travel/features/auth/domain/user.dart';

class Review {
  final User user;
  final int destinationId;
  final String comment;
  final int rating;

  const Review({
    required this.user,
    required this.destinationId,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: User.fromJson(json['user']),
      destinationId: json['destinationId'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
