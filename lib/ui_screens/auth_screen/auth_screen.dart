import 'package:flutter/material.dart';
import 'package:mvvm_authorisation/domain/data_providers/auth_api_provider.dart';
import 'package:mvvm_authorisation/domain/services/auth_service.dart';
import 'package:provider/provider.dart';

enum _ViewModelAuthButtonState { canSubmit, authProcess, disable }

class _ViewModelState {
  String authErrorTitle= '';
  String login = '';
  String password = '';
  bool isAuthInProcess = false;

  _ViewModelAuthButtonState get authButtonState {
    if (isAuthInProcess) {
      return _ViewModelAuthButtonState.authProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelAuthButtonState.canSubmit;
    } else {
      return _ViewModelAuthButtonState.disable;
    }
  }

  _ViewModelState();

}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _state = _ViewModelState();
  _ViewModelState get state => _state;

  void changeLogin(String value) {
    if (_state.login == value) return;
    _state.login = value;
    notifyListeners();
  }

  void changePassword(String value) {
    if (_state.password == value) return;
    _state.password = value;
    notifyListeners();
  }

  Future<void> onAuthButtonPressed() async {

    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;

    _state.authErrorTitle = '';
    _state.isAuthInProcess =  true;

    notifyListeners();

    try {
      await _authService.logIn(login, password);
      _state.isAuthInProcess =  false;
      notifyListeners();
    } on AuthApiProviderIncorrectLoginDataError {
      _state.authErrorTitle ='неверный логин';
      _state.isAuthInProcess = false;
      notifyListeners();
    } catch (err) {
      _state.authErrorTitle = 'неудача. попробуй еще раз';
      _state.isAuthInProcess = false;
      notifyListeners();
    }
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const AuthScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              _ErrorMessage(),
              SizedBox(
                height: 8,
              ),
              _LoginTextField(),
              SizedBox(
                height: 8,
              ),
              _PasswordTextField(),
              SizedBox(
                height: 8.0,
              ),
              _ButtonSubmit(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Login',
        border: OutlineInputBorder(),
      ),
      onChanged: model.changeLogin,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(),
      ),
      onChanged: model.changePassword,
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorTitle =
        context.select((_ViewModel model) => model.state.authErrorTitle);
    return Text(errorTitle);
  }
}

class _ButtonSubmit extends StatelessWidget {
  const _ButtonSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authButtonState =
        context.select((_ViewModel vm) => vm.state.authButtonState);
    final model = context.read<_ViewModel>();
    final childButton = authButtonState == _ViewModelAuthButtonState.authProcess
        ? const CircularProgressIndicator()
        : const Text('Submit');
    return ElevatedButton(
      onPressed: authButtonState == _ViewModelAuthButtonState.canSubmit
          ? model.onAuthButtonPressed
          : null,
      child: childButton,
    );
  }
}
