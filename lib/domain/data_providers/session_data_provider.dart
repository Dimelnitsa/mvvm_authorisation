import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = 'api_Kye';
}

class SessionDataProvider {
  final _sharedPreference = SharedPreferences.getInstance();

  Future<String?> apiKey() async {
    return (await _sharedPreference).getString(SessionDataProviderKeys._apiKey);
  }

  Future<void> saveApiKey(String key) async {
    (await _sharedPreference).setString(SessionDataProviderKeys._apiKey, key);
  }

  Future<void> clearApiKey() async {
    (await _sharedPreference).remove(SessionDataProviderKeys._apiKey);
  }
}
