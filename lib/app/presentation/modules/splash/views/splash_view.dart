import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final injector = Injector.of(context);
    ConnectivityRepository repo = injector.connectivityRepository;
    if (await repo.hasInternet) {
      if (await injector.authRepository.isSignedIn) {
        final user = await injector.authRepository.getUserData();
        if (user != null) {
          _goTo(Routes.home);
        } else {
          _goTo(Routes.signIn);
        }
      } else {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
