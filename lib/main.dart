import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'app/data/repository_implementation/auth_repository_impl.dart';
import 'app/data/repository_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/auth_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/auth_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/my_app.dart';

void main() {
  runApp(
    Injector(
      authRepository: AuthRepositoryImpl(
        authApi: AuthApi(http.Client()),
        secureStorage: const FlutterSecureStorage(),
      ),
      connectivityRepository: ConnectivityRepositoryImpl(
        connectivity: Connectivity(),
        internetChecker: InternetChecker(),
      ),
      child: const MyApp(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthRepository authRepository;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
