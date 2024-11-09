import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_yamen_afmin/presentation/tasks/viewmodel/tasks_state.dart';

import '../model/tasks_model.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(const AssignmentState());

  /// Load all assignments data from Firebase Firestore
  Future<void> loadAllAssignmentsData() async {
    try {
      emit(state.copyWith(status: AssignmentStatus.loading));

      final querySnapshot = await FirebaseFirestore.instance.collection('assignments').get();
      final assignmentsData = querySnapshot.docs.map((doc) => AssignmentModel.fromJson(doc.data())).toList();

      emit(state.copyWith(
        status: AssignmentStatus.loaded,
        assignmentsData: assignmentsData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AssignmentStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
