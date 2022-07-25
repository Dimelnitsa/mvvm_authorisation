
import 'package:mvvm_authorisation/domain/data_providers/auth_api_provider.dart';
import 'package:mvvm_authorisation/domain/data_providers/session_data_provider.dart';

class AuthService{
    final _sessionDataProvider = SessionDataProvider();
    final _authApiProvider = AuthApiProvider();

    Future<bool> checkAuth()async{
      final apiKey = await _sessionDataProvider.apiKey();
      return apiKey != null;
    }

   Future<void> logIn(String login, String password)async{
   final api = await _authApiProvider.logIn(login, password);
   _sessionDataProvider.saveApiKey(api);
  }

  Future<void> logOut()async{
      await _sessionDataProvider.clearApiKey();
  }
}