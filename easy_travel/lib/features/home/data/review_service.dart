import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/features/home/data/review_request.dart';
import 'package:easy_travel/features/home/domain/review.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  void addReview(String token, ReviewRequest request) {}

  Future<List<Review>> getReviewsById(int id) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: '${ApiConstants.commentEndpoint}/$id');
    print(uri.toString());

    final response = await http.get(uri);
    if (response.statusCode == HttpStatus.ok) {
      final List jsons = jsonDecode(response.body);
      return jsons.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
