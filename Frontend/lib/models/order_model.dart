class OrderModel {
  final String? id;
  final List<ItemModel> items;
  final String supplier;
  final DateTime requestedDate;
  String status;

  OrderModel({
    this.id,
    required this.items,
    required this.supplier,
    required this.requestedDate,
    required this.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'],
      items: List<ItemModel>.from(
          map['items'].map((item) => ItemModel.fromMap(item))),
      supplier: map['supplier'],
      requestedDate: DateTime.parse(map['requestedDate']),
      status: map['status'],
    );
  }
  set setStatus(String s) => status = s;

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'supplier': supplier,
      'requestedDate': requestedDate.toIso8601String(),
      'status': status,
    };
  }
}

class ItemModel {
  final String name;
  final int quantity;
  final double price;
  ItemModel({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class SupplierModel {
  String id;
  final String supID;
  final String name;
  final String email;
  final String contact;
  final String company;

  SupplierModel({
    required this.id,
    required this.supID,
    required this.name,
    required this.email,
    required this.contact,
    required this.company,
  });

  factory SupplierModel.fromMap(Map<String, dynamic> map) {
    return SupplierModel(
      id: map['_id'],
      supID: map['supID'],
      name: map['sname'],
      email: map['semail'],
      contact: map['scontact'],
      company: map['scompany'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supID': supID,
      'name': name,
      'email': email,
      'contact': contact,
      'company': company,
    };
  }
}
