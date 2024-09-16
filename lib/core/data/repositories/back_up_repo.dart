import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/favorite_note_models.dart';
import 'fav_not_repo.dart';
import 'not_storage_repo.dart';

class BackupService {
  final FavoritesRepository favoritesRepository;

  BackupService({required this.favoritesRepository});

  static const String _favoritesKey = 'favoriteQuestions';
  static const String _notesKey = 'notes';

  Future<void> fetchAndSaveBackup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String myCode = prefs.getString("code_id") ?? "000";

    final url = 'https://auto-sy.com/api/recovery?code_id=$myCode';

    // try {
    final response = await http.get(Uri.parse(url));
    print("restorackup $url ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final favorites = data['favorites'] as List<dynamic>;
      final notes = data['notes'] as List<dynamic>;

      // حفظ المفضلة
      await _saveFavorites(favorites);

      // حفظ الملاحظات
      await _saveNotes(notes);

      print("تم استرجاع البيانات بنجاح وحفظها محلياً");
      //   } else {
      //     throw Exception('Failed to fetch backup data');
      //   }
      // } catch (e) {
      //   print('Error fetching backup data: $e');
      //   rethrow;
      // }
    }
  }

  Future<void> _saveFavorites(List<dynamic> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // استخراج IDs من الأسئلة المفضلة
    List<String> favoriteIds =
        favorites.map((fav) => fav['id'].toString()).toList();

    // حفظ المفضلة في التخزين المحلي
    await prefs.setStringList(_favoritesKey, favoriteIds);
  }

  Future<void> _saveNotes(List<dynamic> notes1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // استخراج الملاحظات وحفظها كـ JSON
    List<Map<String, dynamic>> notes = notes1.map((comp) {
      return {
        'question_id': comp['question_id'],
        'text': comp['text'],
      };
    }).toList();

    String notesJson = json.encode(notes);
    await prefs.setString(_notesKey, notesJson);
  }

  Future<void> backupFavoritesAndNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // جلب الملاحظات
    String? notesJson = prefs.getString("notes");
    List<Note> notes = [];
    if (notesJson != null) {
      List<dynamic> notesList = json.decode(notesJson);
      notes = notesList.map((noteJson) => Note.fromJson(noteJson)).toList();
    }

    // جلب الأسئلة المفضلة
    List<String>? favoriteList = prefs.getStringList('favoriteQuestions');
    List<int> favoriteQuestions = [];
    if (favoriteList != null) {
      favoriteQuestions = favoriteList.map((id) => int.parse(id)).toList();
    }

    // إرسال جميع الملاحظات والأسئلة المفضلة
    List<Future> requests = [];

    String myCode = prefs.getString("code_id") ?? "000";
    // إرسال الملاحظات
    for (Note note in notes) {
      print("backUpdebug note-- ${note.toJson()}");
      requests.add(favoritesRepository.addNote(
        NoteRequest(
          codeId: myCode, // تأكد من استخدام codeId المناسب هنا
          text: note.note,
          questionId: note.questionId.toString(),
        ),
      ));
    }

    // إرسال الأسئلة المفضلة
    for (int questionId in favoriteQuestions) {
      requests.add(favoritesRepository.addFavorite(
        FavoriteRequest(
          codeId: myCode,
          questionId: questionId.toString(),
        ),
      ));
    }

    // انتظار انتهاء جميع الطلبات
    await Future.wait(requests);

    print('Backup completed successfully');
  }
}
