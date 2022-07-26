import 'package:flutter/material.dart';
import 'package:mvvm_authorisation/domain/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget create() {
    return Provider(
      create: (context) => _ViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }
}

class _ViewModel {
  final _authService = AuthService();
  BuildContext context;

  _ViewModel(this.context) {
    init();
  }

  void init() async {
    final isAuth = await _authService.checkAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToAuthScreen();
    }
  }

  void _goToAppScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('main', (route) => false);
  }

  void _goToAuthScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('auth', (route) => false);
  }
}
