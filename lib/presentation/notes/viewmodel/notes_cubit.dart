import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/notes_model.dart';
import 'notes_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(const NoteState());

  /// Load all notes data from Firebase Firestore
  Future<void> loadAllNotesData() async {
    try {
      emit(state.copyWith(status: NoteStatus.loading));

      final querySnapshot = await FirebaseFirestore.instance.collection('notes').get();
      final notesData = querySnapshot.docs.map((doc) => NoteModel.fromJson(doc.data())).toList();

      emit(state.copyWith(
        status: NoteStatus.loaded,
        notesData: notesData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NoteStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
