import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractSharedPreferencesProvider {
  Future<void> setBool({required String key, required bool value});

  Future<bool?> getBool({required String key});

  Future<void> setString({required String key, required String value});

  Future<String?> getString({required String key});

  Future<void> removeString({required String key});
}

// エラーの処理。
/// ThangNP3
class SharedPreferencesFailure implements Exception {
  final String message;

  const SharedPreferencesFailure([
    this.message = 'An unknow exception occured.',
  ]);
}

/// データを非同期にディスクに保持する
/// ThangNP3
class SharedPreferencesProvider implements AbstractSharedPreferencesProvider {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferencesProvider();

  @override
  Future<void> setBool({required String key, required bool value}) async {
    final SharedPreferences prefs = await _prefs;
    final result = await prefs.setBool(key, value);

    if (!result) {
      throw const SharedPreferencesFailure();
    }
  }

  @override
  Future<bool?> getBool({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  @override
  Future<String?> getString({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<void> setString({required String key, required String value}) async {
    final SharedPreferences prefs = await _prefs;
    final result = await prefs.setString(key, value);

    if (!result) {
      throw const SharedPreferencesFailure();
    }
  }

  @override
  Future<void> removeString({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }
}
