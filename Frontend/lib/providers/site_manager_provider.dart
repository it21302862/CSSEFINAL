import 'package:csse/models/user_model.dart';
import 'package:flutter/material.dart';

class SiteManagerProvider with ChangeNotifier {
  List<SiteManagerModel> _siteManagers = [];
  List<SiteManagerModel> _constSiteManagers = [];
  List<SiteManagerModel> get siteManagers => _siteManagers;

  void setSiteManagers(List<SiteManagerModel> managers) {
    _constSiteManagers = managers;
    _siteManagers = managers;
    notifyListeners();
  }

  void clearFilter() {
    _siteManagers = _constSiteManagers;
    notifyListeners();
  }
}
