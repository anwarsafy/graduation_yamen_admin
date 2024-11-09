import '../model/tasks_model.dart';

enum AssignmentStatus { initial, loading, loaded, error }

class AssignmentState {
  final AssignmentStatus status;
  final List<AssignmentModel>? assignmentsData;
  final String? errorMessage;

  const AssignmentState({
    this.status = AssignmentStatus.initial,
    this.assignmentsData,
    this.errorMessage,
  });

  AssignmentState copyWith({
    AssignmentStatus? status,
    List<AssignmentModel>? assignmentsData,
    String? errorMessage,
  }) {
    return AssignmentState(
      status: status ?? this.status,
      assignmentsData: assignmentsData ?? this.assignmentsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
