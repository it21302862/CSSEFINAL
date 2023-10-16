import 'package:csse/models/user_model.dart';
import 'package:csse/services/local_prefs.dart';
import 'package:csse/services/api_handler.dart';
import 'package:csse/utils/constants.dart';

class AuthService {
  final _localPrefs = LocalPreferences.instance;
  final _apiHandler = ApiHandler('$baseUrl/api');

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    try {
      final response = await _apiHandler
          .post('site-managers/login', {'email': email, 'password': password});
      // Assuming your backend returns a token upon successful login
      final String? token = response['_id'];
      if (token != null) {
        _localPrefs.setUid(token);
        _localPrefs.setToken(token);
        _localPrefs.setEmail(email);
      }
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final String? userId = _localPrefs.getUid();
      if (userId != null) {
        final response = await _apiHandler.get('site-managers/$userId');
        return UserModel.fromMap(response);
      }
      return null;
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<void> signOutUser() async {
    try {
      _localPrefs.clearePrefs();
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<String?> signupUser(String email, String password, String name) async {
    try {
      final response = await _apiHandler.post('/site-managers', {
        'email': email,
        'password': password,
        'name': name,
      });

      final String? token = response['_id'];
      if (token != null) {
        _localPrefs.setUid(token);
        _localPrefs.setToken(token);
        _localPrefs.setEmail(email);
      }
      return token;
    } catch (e) {
      throw Error.safeToString(e);
    }
  }
}
