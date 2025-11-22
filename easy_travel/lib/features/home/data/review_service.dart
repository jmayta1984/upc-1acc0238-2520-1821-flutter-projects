import 'dart:convert';
import 'dart:io';

import 'package:easy_travel/core/constants/api_constants.dart';
import 'package:easy_travel/core/storage/token_storage.dart';
import 'package:easy_travel/features/home/data/review_request.dart';
import 'package:easy_travel/features/home/domain/review.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  Future<List<Review>> getReviewsById(int id) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: '${ApiConstants.commentEndpoint}/$id');

    try {
      final response = await http.get(uri);
      if (response.statusCode == HttpStatus.ok) {
        final List jsons = jsonDecode(response.body);
        return jsons.map((json) => Review.fromJson(json)).toList();
      }
      throw Exception('Error: ${response.statusCode}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> submitReview(ReviewRequest request) async {
    final Uri uri = Uri.parse(
      ApiConstants.baseUrl,
    ).replace(path: ApiConstants.commentEndpoint);

    try {
      final token = await TokenStorage().read();
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode != HttpStatus.created) {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
