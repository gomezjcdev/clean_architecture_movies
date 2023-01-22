import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> getUserData() => Future.value(User());

  @override
  Future<bool> get isSignedIn => Future.value(true);
}
