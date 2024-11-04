import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_yamen_afmin/presentation/parents/viewmodel/parent_state.dart';

import '../repositry/parent_repo.dart';


class ParentCubit extends Cubit<ParentState> {
  final ParentRepository _userRepository;

  ParentCubit(this._userRepository) : super(const ParentState());

  Future<void> fetchParents() async {
    emit(state.copyWith(status: ParentStateStatus.loading));
    try {
      final parents = await _userRepository.fetchParents();
      emit(state.copyWith(status: ParentStateStatus.loaded, parents: parents));
    } catch (e) {
      debugPrint('Error fetching parents: ${e.toString()}');
      emit(state.copyWith(status: ParentStateStatus.error, error: e.toString()));
    }
  }
}
