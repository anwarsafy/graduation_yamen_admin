import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/presentation/students/viewmodel/student_state.dart';

import '../repositry/stuent_repo.dart';


class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserState());

  Future<void> fetchStudents() async {
    emit(state.copyWith(status: UserStateStatus.loading));
    try {
      final students = await _userRepository.fetchStudents();
      emit(state.copyWith(status: UserStateStatus.loaded, users: students));
    } catch (e) {
      emit(state.copyWith(status: UserStateStatus.error, error: e.toString()));
    }
  }
}
