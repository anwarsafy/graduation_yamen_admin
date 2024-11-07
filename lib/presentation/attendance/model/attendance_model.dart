import 'package:equatable/equatable.dart';

class AttendanceModel extends Equatable {
  final DateTime? attendanceTime;
  final String? email;
  final String? macAddress;
  final String? qrID;
  final String? userId;

  const AttendanceModel({
    this.attendanceTime,
    this.email,
    this.macAddress,
    this.qrID,
    this.userId,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      attendanceTime: json['attendanceTime'] != null ? DateTime.parse(json['attendanceTime']) : null,
      email: json['email'],
      macAddress: json['macAddress'],
      qrID: json['qrID'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendanceTime': attendanceTime?.toIso8601String(),
      'email': email,
      'macAddress': macAddress,
      'qrID': qrID,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [attendanceTime, email, macAddress, qrID, userId];
}
