import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/parent_model.dart';

class ParentRepository {
  final FirebaseFirestore _firestore;

  ParentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Parent>> fetchParents() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'parent')
          .get();

      return querySnapshot.docs
          .map((doc) => Parent.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch parents');
    }
  }
}
