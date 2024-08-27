import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Note {
  final int questionId;
  final String note;

  Note({
    required this.questionId,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'note': note,
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      questionId: json['questionId'],
      note: json['note'],
    );
  }
}

class NoteStorage {
  static const String _notesKey = "notes";

  Future<List<Note>> getNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesJson = prefs.getString(_notesKey);
    if (notesJson == null) {
      return [];
    }

    List<dynamic> notesList = json.decode(notesJson);
    return notesList.map((noteJson) => Note.fromJson(noteJson)).toList();
  }

  Future<void> saveNoteForQuestion(int questionId, String noteText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Note> notes = await getNotes();

    // تحديث أو إضافة الملاحظة الجديدة
    int noteIndex = notes.indexWhere((note) => note.questionId == questionId);
    if (noteIndex != -1) {
      notes[noteIndex] = Note(
        questionId: questionId,
        note: noteText,
      );
    } else {
      notes.add(Note(
        questionId: questionId,
        note: noteText,
      ));
    }

    String notesJson = json.encode(notes.map((note) => note.toJson()).toList());
    await prefs.setString(_notesKey, notesJson);
  }

  Future<void> removeNoteForQuestion(int questionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Note> notes = await getNotes();

    // حذف الملاحظة إذا كانت موجودة
    notes.removeWhere((note) => note.questionId == questionId);

    String notesJson = json.encode(notes.map((note) => note.toJson()).toList());
    await prefs.setString(_notesKey, notesJson);
  }

  Future<Note?> getNoteForQuestion(int questionId) async {
    List<Note> notes = await getNotes();
    return notes.firstWhere((note) => note.questionId == questionId);
  }
}
