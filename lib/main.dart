import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db/NotesAdaptor.dart';
import 'package:hive_db/NotesModel.dart';
import 'package:path_provider/path_provider.dart';

import 'homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory=await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
   Hive.registerAdapter(NotesAdaptor()); // Register the type adapter
  await Hive.openBox<NotesPad>('NotesPad');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Notes Pad'),
    );
  }
}

