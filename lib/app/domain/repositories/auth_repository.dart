import '../models/user.dart';

abstract class AuthRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
}
