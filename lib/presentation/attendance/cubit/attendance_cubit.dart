import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/attendance_model.dart';
import 'attendance_state.dart';



class SimplifiedAttendanceCubit extends Cubit<SimplifiedAttendanceState> {
  SimplifiedAttendanceCubit() : super(const SimplifiedAttendanceState());

  /// Load all attendance data directly from Firebase Firestore
  Future<void> loadAllAttendanceData() async {
    try {
      emit(state.copyWith(status: AttendanceStatus.loading));

      final querySnapshot = await FirebaseFirestore.instance.collection('attendance').get();
      final attendanceData = querySnapshot.docs.map((doc) => AttendanceModel.fromJson(doc.data())).toList();

      emit(state.copyWith(
        status: AttendanceStatus.loaded,
        attendanceData: attendanceData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AttendanceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
