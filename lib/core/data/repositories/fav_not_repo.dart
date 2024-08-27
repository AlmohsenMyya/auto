import '../models/favorite_note_models.dart';
import '../network/api_client.dart';

class FavoritesRepository {
  final ApiClient apiClient;

  FavoritesRepository({required this.apiClient});

  Future<void> addFavorite(FavoriteRequest request) async {
    try {
      final response = await apiClient.post('favorites', request.toJson());
      print('Added to favorites: ${response.body}');
    } catch (e) {
      print('Error adding to favorites: $e ');
      throw e;
    }
  }

  Future<void> removeFavorite(String codeId, String questionId) async {
    try {
      final response = await apiClient.delete('favorites', params: {
        'code_id': codeId.toString(),
        'question_id': questionId.toString(),
      });
      print('Removed from favorites: ${response.body}');
    } catch (e) {
      print('Error removing from favorites: $e');
      throw e;
    }
  }

  Future<void> addComplaints(ComplaintsRequest request) async {
    // try {
    final response = await apiClient.post('complaints', request.toJson());
    print('complaints complaints added: ${response.statusCode}${response.body}');
    // } catch (e) {
    //   print('Error adding note: $e');
    //   throw e;
    // }
  }
  Future<void> addNote(NoteRequest request) async {
    // try {
      final response = await apiClient.post('notes', request.toJson());
      print('backUpdebug Note added: ${response.statusCode}${response.body}');
    // } catch (e) {
    //   print('Error adding note: $e');
    //   throw e;
    // }
  }

  Future<void> deleteNote(String codeId, String questionId) async {
    // تحويل الـ codeId و questionId إلى int
    int? parsedCodeId = int.tryParse(codeId);
    int? parsedQuestionId = int.tryParse(questionId);

    if (parsedCodeId == null || parsedQuestionId == null) {
      throw FormatException("Invalid codeId or questionId format");
    }

    Map<String, dynamic> params = {
      'code_id': parsedCodeId.toString(),
      'question_id': parsedQuestionId.toString(),
    };

    await apiClient.delete('notes', params: params);
  }
}
