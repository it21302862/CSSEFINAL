import 'dart:convert';

import 'package:csse/models/site_model.dart';
import 'package:csse/services/api_handler.dart';
import 'package:csse/utils/constants.dart';
import 'package:http/http.dart' as http;

class SiteService {
  final ApiHandler _apiHandler =
      ApiHandler('$baseUrl/api'); // Replace with your backend base URL

  Future<void> createSite(SiteModel site) async {
    try {
      await _apiHandler.post('sites', site.toMap());
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<SiteModel> getSiteById(String id) async {
    try {
      final response = await _apiHandler.get('sites/$id');
      return SiteModel.fromMap(response);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<List<SiteModel>> getAllSites(String email) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/site/$email'));
      List l = jsonDecode(response.body).toList();
      return l.map((e) => SiteModel.fromMap(e)).toList();
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<void> updateSite(SiteModel site) async {
    try {
      await _apiHandler.put('sites/${site.id}', site.toMap());
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<void> deleteSite(String id) async {
    try {
      await _apiHandler.delete('sites/$id');
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<List<SiteModel>> getSitesByCreatedBy(String createdBy) async {
    try {
      final response = await _apiHandler.get('sites?createdBy=$createdBy');
      return (response as List).map((item) => SiteModel.fromMap(item)).toList();
    } catch (e) {
      throw Error.safeToString(e);
    }
  }
}
