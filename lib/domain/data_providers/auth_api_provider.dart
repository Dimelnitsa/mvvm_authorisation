

class AuthApiProvider{

  Future<String> logIn(String login, String password)async{
    final isSuccess = login == 'admin' && password == '1234';
    if (isSuccess) {return 'sdffaldsfsdaflkjlw';}
        else { throw AuthApiProviderIncorrectLoginDataError();}
  }
}

class AuthApiProviderIncorrectLoginDataError{}

abstract class AuthApiProviderError{}