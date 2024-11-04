import 'package:equatable/equatable.dart';
import '../model/parent_model.dart';

enum ParentStateStatus { initial, loading, loaded, error }

class ParentState extends Equatable {
  final ParentStateStatus status;
  final List<Parent> parents;
  final String? error;

  const ParentState({
    this.status = ParentStateStatus.initial,
    this.parents = const [],
    this.error,
  });

  ParentState copyWith({
    ParentStateStatus? status,
    List<Parent>? parents,
    String? error,
  }) {
    return ParentState(
      status: status ?? this.status,
      parents: parents ?? this.parents,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, parents, error];
}
