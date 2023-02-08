import '../enums.dart';
import '../models/user.dart';
import 'either.dart';

abstract class AuthRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<Either<SignInFailure, User>> signIn(String username, String password);
}
