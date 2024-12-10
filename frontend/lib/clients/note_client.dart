import 'package:frontend/models/note.dart';
import 'package:get/get.dart';

class NoteClient extends GetConnect {
  final fakeLoadingTime = 2;
  final mock = List.generate(3, (_) => Note.random());

  Future<List<Note>> fetchNotes() async {
    await Future.delayed(Duration(seconds: fakeLoadingTime));
    return mock;
  }
}