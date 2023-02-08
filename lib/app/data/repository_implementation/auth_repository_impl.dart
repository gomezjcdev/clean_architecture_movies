import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/either.dart';

const _key = 'sessionId';

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({required this.secureStorage});

  @override
  Future<User?> getUserData() => Future.value(User());

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (username != 'test') {
      return Either.left(SignInFailure.notFound);
    }

    if (password != '123456') {
      return Either.left(SignInFailure.unAuthorized);
    }

    return Either.right(User());
  }
}
