import 'package:equatable/equatable.dart';
import '../../students/model/student_model.dart';

class Parent extends Equatable {
  final String email;
  final String name;
  final String nationalId;
  final String nationalIdImageUrl;
  final String relationWithStudent;
  final Map<String, dynamic> selectedStudent;
  final List<String> studentIds;
  final String userId;
  final UserType userType;

  const Parent({
    required this.email,
    required this.name,
    required this.nationalId,
    required this.nationalIdImageUrl,
    required this.relationWithStudent,
    required this.selectedStudent,
    required this.studentIds,
    required this.userId,
    required this.userType,
  });

  @override
  List<Object?> get props => [
    email,
    name,
    nationalId,
    nationalIdImageUrl,
    relationWithStudent,
    selectedStudent,
    studentIds,
    userId,
    userType,
  ];

  // Factory constructor to create Parent from Firestore data
// Factory constructor to create Parent from Firestore data
  factory Parent.fromMap(Map<String, dynamic> map, String documentId) {
    final selectedStudent = map['selectedStudent'] as Map<String, dynamic>? ?? {};
    final studentIds = selectedStudent.containsKey('studentIds')
        ? List<String>.from(selectedStudent['studentIds'])
        : <String>[];

    return Parent(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      nationalId: map['nationalId'] ?? '',
      nationalIdImageUrl: map['nationalIdImageUrl'] ?? '',
      relationWithStudent: map['relationWithStudent'] ?? '',
      selectedStudent: selectedStudent,
      studentIds: studentIds,
      userId: documentId,
      userType: UserType.values.firstWhere(
            (e) => e.toString() == 'UserType.${map['userType']}',
        orElse: () => UserType.parent // default if no match
      ),
    );
  }

  // Convert Parent instance to Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'nationalId': nationalId,
      'nationalIdImageUrl': nationalIdImageUrl,
      'relationWithStudent': relationWithStudent,
      'selectedStudent': {
        ...selectedStudent,
        'studentIds': studentIds,
      },
      'userType': userType.toString().split('.').last,
    };
  }
}
