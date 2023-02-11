import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../domain/enums.dart';
import '../../../domain/repositories/either.dart';

class AuthApi {
  AuthApi(this._client);

  final Client _client;
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _apiKey = 'df85230ae78bf81143872f10b0e0163e';

  Future<String?> createRequestToken() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final json = Map<String, dynamic>.from(jsonDecode(response.body));
        return json['request_token'];
      }

      return null;
    } catch (error) {
      return null;
    }
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/authentication/session/new?api_key=$_apiKey'),
        body: jsonEncode({'request_token': requestToken}),
      );

      if (response.statusCode == 200) {
        final json = Map<String, dynamic>.from(jsonDecode(response.body));
        final sessionId = json['session_id'] as String;
        return Either.right(sessionId);
      }
      return Either.left(SignInFailure.unknown);
    } catch (error) {
      if (error is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
          '$_baseUrl/authentication/token/validate_with_login?api_key=$_apiKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'request_token': requestToken,
        }),
      );

      switch (response.statusCode) {
        case 200:
          final json = Map<String, dynamic>.from(jsonDecode(response.body));
          return Either.right(json['request_token']);
        case 401:
          return Either.left(SignInFailure.unAuthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (error) {
      if (error is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }
}
