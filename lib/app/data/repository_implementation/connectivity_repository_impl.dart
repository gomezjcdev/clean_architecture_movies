import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/repositories/connectivity_repository.dart';
import '../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity connectivity;
  final InternetChecker internetChecker;

  ConnectivityRepositoryImpl({
    required this.connectivity,
    required this.internetChecker,
  });

  @override
  Future<bool> get hasInternet async {
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
    return internetChecker.hasInternet();
  }
}
