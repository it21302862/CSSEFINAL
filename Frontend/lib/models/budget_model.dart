import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  final String? id;
  final String siteId;
  final double amount;
  final DateTime requestDate;
  final DateTime approvalDate;
  final String status;

  Budget({
    this.id,
    required this.siteId,
    required this.amount,
    required this.requestDate,
    required this.approvalDate,
    required this.status,
  });

  factory Budget.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Budget(
      id: snapshot.id,
      siteId: data['siteId'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      requestDate: data['requestDate'].toDate(),
      approvalDate: data['approvalDate'].toDate(),
      status: data['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'siteId': siteId,
      'amount': amount,
      'requestDate': requestDate,
      'approvalDate': approvalDate,
      'status': status,
    };
  }
}
