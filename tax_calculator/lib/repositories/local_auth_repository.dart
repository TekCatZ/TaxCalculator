import 'package:local_auth/local_auth.dart';
import 'package:tax_calculator/constants/shared_pref_key_constants.dart';
import 'package:tax_calculator/data/local/shared_preferences_provider.dart';

abstract class AbstractLocalAuthRepository {
  Future<void> checkIfEnableLocalAuth();

  Future<bool> authenication();

  Future<bool> authenticateIsAvailable();

  bool canCheckLocalAuth();

  bool isEnableLocalAuth();
}

class LocalAuthRepositoryFailure implements Exception {
  final String message;

  const LocalAuthRepositoryFailure([
    this.message = 'An unknow exception occured.',
  ]);
}

// 生体認証の処理すること。
// ThangNP3
class LocalAuthRepository implements AbstractLocalAuthRepository {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final SharedPreferencesProvider _sharedPreferencesProvider;
  bool _canCheckLocalAuth = false;
  bool _isEnableLocalAuth = false;

  LocalAuthRepository(this._sharedPreferencesProvider);

  // デバイスの生体認証できる取得する。
  @override
  bool canCheckLocalAuth() {
    return _canCheckLocalAuth;
  }

  // 生体認証取得する
  @override
  bool isEnableLocalAuth() {
    return _isEnableLocalAuth;
  }

  // デバイスの生体認証できるチェックする。
  @override
  Future<bool> authenticateIsAvailable() async {
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  // 生体認証チェックする
  @override
  Future<void> checkIfEnableLocalAuth() async {
    _canCheckLocalAuth = false;
    _isEnableLocalAuth = false;

    try {
      _canCheckLocalAuth = await authenticateIsAvailable();
      final storedPrefValue = await _sharedPreferencesProvider.getBool(
              key: SharedPrefKeyConstants.enableLocalAuth) ??
          false;

      if (storedPrefValue && _canCheckLocalAuth) {
        _isEnableLocalAuth = true;
      }
    } catch (e) {}
  }

  /// 認証をチェックする。
  @override
  Future<bool> authenication() async {
    // 最新の認証アクセスを取得するため(アプリ起動中に認証を登録する)。
    _canCheckLocalAuth = await authenticateIsAvailable();
    if (_canCheckLocalAuth) {
      try {
        final authenticated = await _localAuth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          // in order to not failure when user have call and resumes again
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );

        return authenticated;
      } catch (e) {
        throw const LocalAuthRepositoryFailure();
      }
    } else {
      throw const LocalAuthRepositoryFailure(
          "Seems you don't have biometrics auth. Please recheck and try again");
    }
  }
}
