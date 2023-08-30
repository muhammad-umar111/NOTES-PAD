import 'package:hive/hive.dart';

import 'NotesModel.dart';

class Boxes {
  static Box<NotesPad> getData()=> Hive.box<NotesPad>('NotesPad');
}