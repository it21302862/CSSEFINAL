import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse/models/site_model.dart';
import 'package:csse/models/user_model.dart';
import 'package:csse/services/auth_service.dart';
import 'package:csse/services/site_service.dart';
import 'package:csse/utils/collection_names.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();
  final _siteService = SiteService();
  Future<void> addUser(UserModel user, String password) async {
    try {
      // await _authService.signupUser(user.email, password).then((value) async {
      //   await _firestore.collection(usersCollection).doc(value).set(
      //         user.toMap(),
      //       );
      // });
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<List<SiteManagerModel>> getSiteManagers() async {
    List<SiteManagerModel> managers = [];
    try {
      await _firestore
          .collection(usersCollection)
          .where('role', isEqualTo: "siteManager")
          .get()
          .then((value) async {
        for (DocumentSnapshot snapshot in value.docs) {}
      });
      return managers;
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }
}
