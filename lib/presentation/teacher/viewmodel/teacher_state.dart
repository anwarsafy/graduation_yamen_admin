import 'package:equatable/equatable.dart';
import '../model/teacher_model.dart';

enum TeacherStateStatus { initial, loading, loaded, error }

class TeacherState extends Equatable {
  final TeacherStateStatus status;
  final List<Teacher> teachers;
  final String? error;

  const TeacherState({
    this.status = TeacherStateStatus.initial,
    this.teachers = const [],
    this.error,
  });

  TeacherState copyWith({
    TeacherStateStatus? status,
    List<Teacher>? teachers,
    String? error,
  }) {
    return TeacherState(
      status: status ?? this.status,
      teachers: teachers ?? this.teachers,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, teachers, error];
}
