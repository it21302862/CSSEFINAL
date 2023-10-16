import 'package:csse/models/site_model.dart';
import 'package:csse/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  SiteModel? _site;
  UserModel? get user => _user;
  SiteModel? get site => _site;
  void updateUser(UserModel newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setSite(SiteModel site) {
    _site = site;
    notifyListeners();
  }
}
