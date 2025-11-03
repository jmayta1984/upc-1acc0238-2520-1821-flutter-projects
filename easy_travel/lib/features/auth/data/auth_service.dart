import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_travel/features/auth/domain/user.dart';

class AuthService {
  final String _baseUrl =
      "https://destinationapp-h4e8dvace3fqffbb.eastus-01.azurewebsites.net/api/users/login";

  Future<User> signIn(String email, String password) async {

    final response = await http.post(
      Uri.parse(_baseUrl),

      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    }

    return Future.error('Failed to login');
  }
}
