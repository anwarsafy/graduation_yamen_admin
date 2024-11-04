import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/teacher_model.dart';

class TeacherRepository {
  final FirebaseFirestore _firestore;

  TeacherRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Teacher>> fetchTeachers() async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'teacher')
          .get();

      return querySnapshot.docs.map((doc) => Teacher.fromMap(doc.data(), doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to fetch teachers');
    }
  }
}
