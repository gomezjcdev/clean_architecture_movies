import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/either.dart';
import '../services/remote/auth_api.dart';

const _key = 'sessionId';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.secureStorage, required this.authApi});
  final FlutterSecureStorage secureStorage;
  final AuthApi authApi;

  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password) async {
    final requestToken = await authApi.createRequestToken();

    if (username != 'test') {
      return Either.left(SignInFailure.notFound);
    }

    if (password != '123456') {
      return Either.left(SignInFailure.unAuthorized);
    }

    await secureStorage.write(key: _key, value: requestToken);

    return Either.right(User());
  }

  @override
  Future<void> signOut() {
    return secureStorage.delete(key: _key);
  }
}
