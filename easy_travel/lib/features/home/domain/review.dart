import 'package:easy_travel/features/auth/domain/user.dart';

class Review {
  final User user;
  final int destinationId;
  final String comment;
  final int rating;
  final DateTime date;

  const Review({
    required this.user,
    required this.destinationId,
    required this.comment,
    required this.rating,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: User.fromJson(json['user']),
      destinationId: json['destinationId'],
      comment: json['comment'],
      rating: json['rating'],
      date: DateTime.parse(json['date']),
    );
  }
}
