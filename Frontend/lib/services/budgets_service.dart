import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse/utils/collection_names.dart';
import 'package:logger/logger.dart';

class BudgetsService {
  final _firestore = FirebaseFirestore.instance;
  Future<double> fetchBudget(String siteId) async {
    try {
      return await _firestore
          .collection(budgetCollection)
          .where("siteManagerId", isEqualTo: siteId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          return double.parse((value.docs.first)['budget']);
        }
        return 0.0;
      });
    } catch (e) {
      Logger().e(e);
      return 0.0;
    }
  }
}
