import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:csse/models/order_model.dart' as s;

class AddOrderModel {
  final String? id;
  String requestedBy;
  String siteId;
  DateTime requesingDate;
  String address;
  String supplier;
  String contactNumber;
  List<OrderItem> items;
  final String status;
  AddOrderModel({
    this.id,
    required this.requestedBy,
    required this.siteId,
    required this.requesingDate,
    required this.address,
    required this.contactNumber,
    required this.items,
    required this.supplier,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'requestedBy': requestedBy,
      'siteId': siteId,
      'status': status,
      'supplier': supplier,
      'requestedTo': supplier,
      'requesingDate': requesingDate.toIso8601String(),
      'address': address,
      'contactNumber': contactNumber,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory AddOrderModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    try {
      return AddOrderModel(
        id: snapshot.id,
        requestedBy: data['requestedBy'] ?? '',
        siteId: data['siteId'] ?? '',
        requesingDate: DateTime.parse(data['requesingDate']),
        address: data['address'] ?? '',
        supplier: data['requestedTo'] ?? '',
        contactNumber: data['contactNumber'] ?? '',
        items: (data['items'] as List<dynamic>)
            .map((itemData) => OrderItem.fromMap(itemData))
            .toList(),
        status: data['status'] ?? 'pending',
      );
    } catch (e) {
      Logger().e(e);
      throw Error.safeToString("Error converting map");
    }
  }

  set setRequestedBy(String r) => requestedBy = r;
  set setSiteId(String s) => siteId = s;
  set setRequesingDate(DateTime date) => requesingDate = date;
  set setAddress(String a) => address = a;
  set setContactNumber(String number) => contactNumber = number;
  set setItems(List<OrderItem> i) => items = i;
  set setSuppler(String s) => supplier = s;
}

class OrderItem {
  final String name;
  final String id;
  final int qty;
  final double price;
  OrderItem({
    required this.name,
    required this.id,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'qty': qty,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<dynamic, dynamic> map) {
    return OrderItem(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      qty: int.parse(map['quantity'].toString()),
      price: map['price'] * 1.0,
    );
  }
}
