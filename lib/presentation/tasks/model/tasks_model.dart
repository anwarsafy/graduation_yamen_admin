import 'package:equatable/equatable.dart';

class AssignmentModel extends Equatable {
  final String? courseName;
  final String? department;
  final String? level;
  final DateTime? taskDate;
  final String? taskType;
  final List<String>? students;

  const AssignmentModel({
    this.courseName,
    this.department,
    this.level,
    this.taskDate,
    this.taskType,
    this.students,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      courseName: json['courseName'],
      department: json['department'],
      level: json['level'],
      taskDate: json['taskDate'] != null ? DateTime.parse(json['taskDate']) : null,
      taskType: json['taskType'],
      students: json['students'] != null ? List<String>.from(json['students']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'department': department,
      'level': level,
      'taskDate': taskDate?.toIso8601String(),
      'taskType': taskType,
      'students': students,
    };
  }

  @override
  List<Object?> get props => [courseName, department, level, taskDate, taskType, students];
}
