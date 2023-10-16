import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  final String _token = "uid";
  final String _email = "email";

  static LocalPreferences? _instance;
  SharedPreferences? _sharedPreferences;

  LocalPreferences._();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static LocalPreferences get instance {
    _instance ??= LocalPreferences._();
    return _instance!;
  }

  void setEmail(String email) {
    _sharedPreferences!.setString(_email, email);
  }

  Future<String?> getEmail() async {
    return _sharedPreferences!.getString(_email);
  }

  void clearePrefs() {
    _sharedPreferences?.clear();
  }

  void setUid(String uid) {
    _sharedPreferences!.setString(_token, uid);
  }

  String? getUid() {
    return _sharedPreferences?.getString(_token);
  }

  void setToken(String token) {
    _sharedPreferences!.setString(_token, token);
  }

  Future<String?> getToken() async {
    return _sharedPreferences!.getString(_token);
  }
}
