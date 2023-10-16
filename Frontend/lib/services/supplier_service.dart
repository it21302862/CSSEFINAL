import 'dart:convert';

import 'package:csse/models/order_model.dart';
import 'package:csse/services/api_handler.dart';
import 'package:csse/utils/constants.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class SupplierService {
  final ApiHandler _apiHandler =
      ApiHandler('$baseUrl/api/'); // Replace with your backend base URL

  Future<void> addSupplier(SupplierModel supplier) async {
    try {
      await _apiHandler.post('suppliers', supplier.toMap());
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<SupplierModel> getSupplierById(String id) async {
    try {
      final response = await _apiHandler.get('suppliers/$id');
      return SupplierModel.fromMap(response);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<List<SupplierModel>> getAllSuppliers() async {
    try {
      List<SupplierModel> s = [];
      final response = await http.get(Uri.parse('$baseUrl/api/suppliers'));

      List l = jsonDecode(response.body).toList();
      s = l.map((e) => SupplierModel.fromMap(e)).toList();
      return s;
    } catch (e) {
      Logger().e('$e');
      throw Error.safeToString(e);
    }
  }

  Future<void> updateSupplier(SupplierModel supplier) async {
    try {
      await _apiHandler.put('suppliers/${supplier.id}', supplier.toMap());
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<void> deleteSupplier(String id) async {
    try {
      await _apiHandler.delete('suppliers/$id');
    } catch (e) {
      throw Error.safeToString(e);
    }
  }
}
