import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/student_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<User>> fetchStudents() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'student')
          .get();

      return querySnapshot.docs.map((doc) => User.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to fetch students');
    }
  }
}
