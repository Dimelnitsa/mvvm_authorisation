

class AuthApiProvider{

  Future<String> logIn(String login, String password)async{
    await Future.delayed(const Duration(seconds: 2));
    final isSuccess = login == 'admin' && password == '12345678';
    if (isSuccess) {return 'sdffaldsfsdaflkjlw';}
        else { throw AuthApiProviderIncorrectLoginDataError();}
  }
}

class AuthApiProviderIncorrectLoginDataError{}

abstract class AuthApiProviderError{}