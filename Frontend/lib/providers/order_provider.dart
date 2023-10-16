import 'package:csse/models/order_model.dart';
import 'package:csse/services/order_service.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orders = [];
  final OrderService orderService = OrderService();
  Future<void> setOrders() async {
    try {
      orders = await orderService.getOrders();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
