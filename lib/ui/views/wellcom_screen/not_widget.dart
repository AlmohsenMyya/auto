import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/models/favorite_note_models.dart';
import '../../../core/data/network/api_client.dart';
import '../../../core/data/repositories/fav_not_repo.dart';
import '../../../core/data/repositories/not_storage_repo.dart';

class NoteDialogWidget extends StatefulWidget {
  final int questionId;

  const NoteDialogWidget({
    required this.questionId,
  });

  @override
  _NoteDialogWidgetState createState() => _NoteDialogWidgetState();
}

class _NoteDialogWidgetState extends State<NoteDialogWidget> {
  late TextEditingController _noteController;
  late String _note = " ";
  late ApiClient apiClient;
  NoteStorage noteStorage = NoteStorage();

  late FavoritesRepository favoritesRepository;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    getNoteForQuestion(widget.questionId);
    _noteController.text = _note;

    apiClient = ApiClient(baseUrl: 'https://auto-sy.com/api');
    favoritesRepository = FavoritesRepository(apiClient: apiClient);
  }

  void getNoteForQuestion(int questionId) async {
    Note? note = await noteStorage.getNoteForQuestion(questionId);
    setState(() {
      _note = note?.note ?? "";
      _noteController.text = _note;
      print("kkkk $note");
    });
  }

  void saveNoteForQuestion(int questionId, String note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await noteStorage.saveNoteForQuestion(questionId, note);

    String myCode = prefs.getString("code_id") ?? "000";
    // Add note
    favoritesRepository.addNote(NoteRequest(
        codeId: myCode, text: note, questionId: questionId.toString()));

    setState(() {
      _note = note;
    });
  }

  void removeNoteForQuestion(int questionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myCode = prefs.getString("code_id") ?? "000";
    // Add note
    favoritesRepository.deleteNote(myCode, questionId.toString());
    await noteStorage.removeNoteForQuestion(questionId);

    setState(() {
      _note = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'ملاحظة',
        style: TextStyle(fontSize: 24),
      ),
      content: TextField(
        controller: _noteController,
        decoration: InputDecoration(
          hintText: "أدخل ملاحظتك هنا",
        ),
        maxLines: 10,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('حفظ'),
              onPressed: () {
                saveNoteForQuestion(widget.questionId, _noteController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('إزالة '),
              onPressed: () {
                removeNoteForQuestion(widget.questionId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
