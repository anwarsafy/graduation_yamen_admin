import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/presentation/teacher/viewmodel/teacher_state.dart';

import '../repositry/teacher_repo.dart';


class TeacherCubit extends Cubit<TeacherState> {
  final TeacherRepository _userRepository;

  TeacherCubit(this._userRepository) : super(const TeacherState());

  Future<void> fetchTeachers() async {
    emit(state.copyWith(status: TeacherStateStatus.loading));
    try {
      final teachers = await _userRepository.fetchTeachers();
      emit(state.copyWith(status: TeacherStateStatus.loaded, teachers: teachers));
    } catch (e) {
      emit(state.copyWith(status: TeacherStateStatus.error, error: e.toString()));
    }
  }
}
