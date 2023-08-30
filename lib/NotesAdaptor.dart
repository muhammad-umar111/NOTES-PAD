import 'package:hive/hive.dart';
import 'package:hive_db/NotesModel.dart';

class NotesAdaptor extends TypeAdapter<NotesPad>{
  @override
  NotesPad read(BinaryReader reader) {
    return NotesPad(
      title:reader.read() ,
     description:reader.read())
    ;
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, NotesPad obj) {
     writer.write(obj.title);
     writer.write(obj.description);
  }

}