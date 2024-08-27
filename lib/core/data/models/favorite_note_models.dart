class FavoriteRequest {
  final String codeId;
  final String questionId;

  FavoriteRequest({required this.codeId, required this.questionId});

  Map<String, dynamic> toJson() {
    int? parsedCodeId = int.tryParse(codeId);
    int? parsedQuestionId = int.tryParse(questionId);

    if (parsedCodeId == null || parsedQuestionId == null) {
      throw FormatException("Invalid codeId or questionId format");
    }

    return {
      'code_id': parsedCodeId,
      'question_id': parsedQuestionId,
    };
  }
}

class NoteRequest {
  final String codeId;
  final String text;
  final String questionId;

  NoteRequest({required this.codeId, required this.text, required this.questionId});

  Map<String, dynamic> toJson() {
    int? parsedCodeId = int.tryParse(codeId);
    int? parsedQuestionId = int.tryParse(questionId);

    if (parsedCodeId == null || parsedQuestionId == null) {
      throw FormatException("Invalid codeId or questionId format");
    }

    return {
      'code_id': codeId,
      'text': text,
      'question_id': questionId,
    };
  }
}
class ComplaintsRequest {
  final String codeId;
  final String text;
  final String questionId;

  ComplaintsRequest({required this.codeId, required this.text, required this.questionId});

  Map<String, dynamic> toJson() {
    int? parsedCodeId = int.tryParse(codeId);
    int? parsedQuestionId = int.tryParse(questionId);

    if (parsedCodeId == null || parsedQuestionId == null) {
      throw FormatException("Invalid codeId or questionId format");
    }

    return {
      'code_id': codeId,
      'text': text,
      'question_id': questionId,
    };
  }
}