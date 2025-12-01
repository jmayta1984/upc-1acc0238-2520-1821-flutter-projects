import 'dart:convert';
import 'dart:io';

import 'package:easy_meal/core/constants/api_constants.dart';
import 'package:easy_meal/data/remote/meal_dto.dart';
import 'package:http/http.dart' as http;

class MealService {
  Future<List<MealDto>> getMealsByCategory(String category) async {
    final Uri uri = Uri.parse(ApiConstants.baseUrl).replace(
      path: ApiConstants.mealsByCategoryEndpoint,
      queryParameters: {'c': category},
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = jsonDecode(response.body);
        final List jsons = jsonResponse['meals'];
        return jsons.map((json) => MealDto.fromJson(json)).toList();
      }
      return Future.error('Failed to load meals: ${response.statusCode}');
      
    } catch (e) {
      return Future.error('Failed to load meals: $e');
    }
  }
}
