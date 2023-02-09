import 'dart:convert';

import 'package:http/http.dart';

class AuthApi {
  AuthApi(this._client);

  final Client _client;
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = 'df85230ae78bf81143872f10b0e0163e';

  Future<String?> createRequestToken() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final json = Map<String, dynamic>.from(jsonDecode(response.body));
      return json['request_token'];
    }

    return null;
  }
}
