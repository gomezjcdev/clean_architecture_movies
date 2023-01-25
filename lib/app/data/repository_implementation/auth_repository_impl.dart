import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

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
}
