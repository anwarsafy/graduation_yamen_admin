import 'package:equatable/equatable.dart';
import '../model/student_model.dart';

enum UserStateStatus { initial, loading, loaded, error }

class UserState extends Equatable {
  final UserStateStatus status;
  final List<User> users;
  final String? error;

  const UserState({
    this.status = UserStateStatus.initial,
    this.users = const [],
    this.error,
  });

  UserState copyWith({
    UserStateStatus? status,
    List<User>? users,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, users, error];
}
