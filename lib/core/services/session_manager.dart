import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  static const keyToken = "USER_TOKEN";
  static const refreshKeyToken = "REFRESH_USER_TOKEN";
  static const authorizeToken = "authorization";
  final _storage = const FlutterSecureStorage();

  factory SessionManager() {
    return _instance;
  }
  SessionManager._internal();

   Future<void> deleteToken() async {
    await _storage.delete(key: keyToken);
    return;
  }

  Future<void> persistToken(String token) async {
     _storage.write(key: keyToken, value: token);
    return;
  }

  Future<void> persistRefreshToken(String token) async {
    _storage.write(key: refreshKeyToken, value: token);
    return;
  }

  Future<String> get authToken async {
    return await _storage.read(key: keyToken);
  }

  Future<String> get refreshToken async {
    return await _storage.read(key: refreshKeyToken);
  }

  Future<bool> get hasToken async {
   return await _storage.containsKey(key: keyToken);
  }

}
