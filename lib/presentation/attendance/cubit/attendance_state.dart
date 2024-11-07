import '../model/attendance_model.dart';

enum AttendanceStatus { initial, loading, loaded, error }

class SimplifiedAttendanceState {
  final AttendanceStatus status;
  final List<AttendanceModel>? attendanceData;
  final String? errorMessage;

  const SimplifiedAttendanceState({
    this.status = AttendanceStatus.initial,
    this.attendanceData,
    this.errorMessage,
  });

  SimplifiedAttendanceState copyWith({
    AttendanceStatus? status,
    List<AttendanceModel>? attendanceData,
    String? errorMessage,
  }) {
    return SimplifiedAttendanceState(
      status: status ?? this.status,
      attendanceData: attendanceData ?? this.attendanceData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}