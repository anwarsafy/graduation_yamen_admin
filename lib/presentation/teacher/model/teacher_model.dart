import 'package:equatable/equatable.dart';

import '../../students/model/student_model.dart';

class Teacher extends Equatable {
  final String email;
  final String name;
  final String jobId;
  final String userId;
  final UserType userType;

  const Teacher({
    required this.email,
    required this.name,
    required this.jobId,
    required this.userId,
    required this.userType,
  });

  @override
  List<Object?> get props => [email, name, jobId, userId, userType];

  // Factory constructor to create Teacher from Firestore data
  factory Teacher.fromMap(Map<String, dynamic> map, String documentId) {
    return Teacher(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      jobId: map['jobId'] ?? '',
      userId: documentId,
      userType: UserType.values.firstWhere((e) => e.toString() == 'UserType.${map['userType']}'),
    );
  }

  // Convert Teacher instance to Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'jobId': jobId,
      'userType': userType.toString().split('.').last,
    };
  }
}
