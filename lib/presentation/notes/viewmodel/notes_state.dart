import '../model/notes_model.dart';

enum NoteStatus { initial, loading, loaded, error }

class NoteState {
  final NoteStatus status;
  final List<NoteModel>? notesData;
  final String? errorMessage;

  const NoteState({
    this.status = NoteStatus.initial,
    this.notesData,
    this.errorMessage,
  });

  NoteState copyWith({
    NoteStatus? status,
    List<NoteModel>? notesData,
    String? errorMessage,
  }) {
    return NoteState(
      status: status ?? this.status,
      notesData: notesData ?? this.notesData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
