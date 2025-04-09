import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;
  
  // Khóa dùng để lưu trữ dữ liệu
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _themeKey = 'app_theme';
  static const String _localeKey = 'app_locale';
  
  StorageService(this._prefs);
  
  // Phương thức làm việc với token
  String? getToken() => _prefs.getString(_tokenKey);
  
  Future<bool> setToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }
  
  Future<bool> removeToken() async {
    return await _prefs.remove(_tokenKey);
  }
  
  // Phương thức làm việc với user ID
  String? getUserId() => _prefs.getString(_userIdKey);
  
  Future<bool> setUserId(String userId) async {
    return await _prefs.setString(_userIdKey, userId);
  }
  
  Future<bool> removeUserId() async {
    return await _prefs.remove(_userIdKey);
  }
  
  // Phương thức làm việc với theme
  bool isDarkMode() => _prefs.getBool(_themeKey) ?? false;
  
  Future<bool> setDarkMode(bool isDark) async {
    return await _prefs.setBool(_themeKey, isDark);
  }
  
  // Phương thức làm việc với locale
  String getLocale() => _prefs.getString(_localeKey) ?? 'en';
  
  Future<bool> setLocale(String locale) async {
    return await _prefs.setString(_localeKey, locale);
  }
  
  // Xóa tất cả dữ liệu
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}