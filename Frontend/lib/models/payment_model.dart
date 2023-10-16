import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String? id;
  final String orderId;
  final double amount;
  final DateTime paymentDate;
  final String status;

  Payment({
    this.id,
    required this.orderId,
    required this.amount,
    required this.paymentDate,
    required this.status,
  });

  factory Payment.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Payment(
      id: snapshot.id,
      orderId: data['orderId'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      paymentDate: data['paymentDate'].toDate(),
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'amount': amount,
      'paymentDate': paymentDate,
      'status': status,
    };
  }
}
