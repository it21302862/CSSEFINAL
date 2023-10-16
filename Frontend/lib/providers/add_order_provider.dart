import 'package:csse/models/add_order_model.dart';
import 'package:csse/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddOrderProvider with ChangeNotifier {
  AddOrderModel orderModel = AddOrderModel(
    requestedBy: '',
    siteId: '',
    supplier: '',
    requesingDate: DateTime.now(),
    address: '',
    contactNumber: '',
    items: [],
  );

  void setDeliveryDetails({
    required String requestedBy,
    required String requestedTo,
    required String siteId,
    required DateTime deliveryDate,
    required String address,
    required String contactNumber,
  }) {
    orderModel.address = address;
    orderModel.contactNumber = contactNumber;
    orderModel.supplier = requestedTo;
    orderModel.requesingDate = deliveryDate;
    orderModel.siteId = siteId;
    orderModel.requestedBy = FirebaseAuth.instance.currentUser?.email ?? '';
    notifyListeners();
  }

  void clearOrder() {
    orderModel = AddOrderModel(
      requestedBy: '',
      siteId: '',
      supplier: '',
      requesingDate: DateTime.now(),
      address: '',
      contactNumber: '',
      items: [],
    );
    notifyListeners();
  }
}
