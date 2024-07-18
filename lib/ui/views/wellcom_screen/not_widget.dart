import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    getNoteForQuestion(widget.questionId);
    _noteController.text = _note;
  }

  void getNoteForQuestion(int questionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final note = prefs.getString('note_$questionId');
    setState(() {
      _note = note ?? "";
      _noteController.text = _note;
      print("kkkk $note");
    });
  }

  void saveNoteForQuestion(int questionId, String note) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_$questionId', note);
    setState(() {
      _note = note;
    });
  }

  void removeNoteForQuestion(int questionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('note_$questionId');
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
        maxLines: 3,
      ),
      actions: <Widget>[
        TextButton(
          child: Text('حفظ'),
          onPressed: () {
            saveNoteForQuestion(widget.questionId, _noteController.text);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('إزالة الملاحظة'),
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
    );
  }
}