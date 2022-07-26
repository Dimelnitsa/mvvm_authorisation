import 'package:flutter/material.dart';
import 'package:mvvm_authorisation/domain/services/auth_service.dart';
import 'package:mvvm_authorisation/ui_screens/navigation/main_navigation.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () => model.onPressedLogOut(context),
                child: const Text('LogOut')),
          ],
        ),
        body: const Center(child: Text('Main Screen')));
  }

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const MainScreen(),
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  Future<void> onPressedLogOut(BuildContext context) async {
    await _authService.logOut();
    MainNavigation.showLoader(context);
   // Navigator.of(context)
     //   .pushNamedAndRemoveUntil('loader', (rout) => false);
  }
}
