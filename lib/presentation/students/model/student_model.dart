import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String nationalId;
  final String studentId;
  final String userId;
  final UserType userType;

  const User({
    required this.email,
    required this.name,
    required this.nationalId,
    required this.studentId,
    required this.userId,
    required this.userType,
  });

  @override
  List<Object?> get props => [email, name, nationalId, studentId, userId, userType];

  // Factory constructor to create User from Firestore data
  factory User.fromMap(Map<String, dynamic> map, String documentId) {
    return User(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      nationalId: map['nationalId'] ?? '',
      studentId: map['studentId'] ?? '',
      userId: documentId,
      userType: UserType.values.firstWhere((e) => e.toString() == 'UserType.${map['userType']}'),
    );
  }

  // Convert User instance to Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'nationalId': nationalId,
      'studentId': studentId,
      'userType': userType.toString().split('.').last,
    };
  }
}

// Enum for user types
enum UserType { student, teacher, admin, parent }
