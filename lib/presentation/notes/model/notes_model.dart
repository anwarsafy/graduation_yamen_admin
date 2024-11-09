import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String? assignedTo;
  final String? authorId;
  final String? authorName;
  final String? content;

  const NoteModel({
    this.assignedTo,
    this.authorId,
    this.authorName,
    this.content,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      assignedTo: json['assignedTo'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assignedTo': assignedTo,
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
    };
  }

  @override
  List<Object?> get props => [assignedTo, authorId, authorName, content];
}
