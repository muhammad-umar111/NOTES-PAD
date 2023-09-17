import 'package:flutter/material.dart';
import 'package:hive_db/Box.dart';
import 'package:hive_db/NotesModel.dart';
import 'package:hive_flutter/adapters.dart';

class MyHomePage extends StatefulWidget {
 const MyHomePage({super.key, required this.title});
 final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> { 
 late TextEditingController topicController;
 late TextEditingController descriptionController;
 @override
 void initState() {
   super.initState();
   topicController=TextEditingController();
   descriptionController=TextEditingController();
 }
 @override
  void dispose() {
  topicController.dispose();
  descriptionController.dispose();
    super.dispose();
  }
  final List<Color> colors = [
    Color.fromARGB(255, 81, 199, 140),
    Color.fromARGB(255, 167, 192, 192),
    Color.fromARGB(255, 73, 87, 140),
     Color.fromARGB(255, 206, 138, 198),
    Color.fromARGB(255, 4, 228, 228),
    Color.fromARGB(255, 155, 174, 132),
    // Add more colors as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(widget.title,style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w800)),
      ),
       body:SafeArea(
         child: ValueListenableBuilder<Box<NotesPad>>(
          valueListenable:Boxes.getData().listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: value.length,
              itemBuilder: (context, index) {
                Color color = colors[index % colors.length];
                var listNotesPad=value.values.toList();
              return Card(
                color: color,
                //index%2==0?Color.fromARGB(255, 30, 116, 187):Color.fromARGB(255, 24, 146, 168),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   Row(
                     children: [
                       Text(listNotesPad[index].title.toString(),
                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                      Spacer(),
                      IconButton(onPressed: (){
                        delete(listNotesPad[index]);
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      IconButton(onPressed:(){
                        editMyDialogue(context,listNotesPad[index],listNotesPad[index].title ,listNotesPad[index].description);
                      }, icon:Icon(Icons.edit,color: Colors.black,))
                     ],
                   ),
                   Text(listNotesPad[index].description.toString())
                    ],
                  ),
                ),
              );
            },);
          },),
       ),
      // Column(
      //   children: <Widget>[
    
      //     // FutureBuilder(
      //     //   future:Hive.openBox('myDetails') ,
      //     //   builder: (context, snapshot) {
      //     //     if (snapshot.hasData) {
      //     //         return ListTile(
      //     //     title: Text('name =${snapshot.data!.get('details')['name']}'),
      //     //     subtitle: Text('profession =${snapshot.data!.get('details')["profession"]}'),
      //     //     trailing: Text('age =${snapshot.data!.get('details')['age']}'),
      //     //   );
      //     //     } else {
      //     //       return Center(child: CircularProgressIndicator(),);
      //     //     }
          
      //     // },)
      //   ],
    
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // For Box Concept.....
          // var box=await Hive.openBox('myDetails');
          // box.put('details',{
          //   'name':'M.Umar',
          //   'age':22,
          //   'profession':'Software Eng.'
          // });
          // print(box.get('details')['name']);
         showMyDialogue(context);
         
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> showMyDialogue(BuildContext context){
  return
  showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('ADD NOTES'),
              titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),
              content: Column(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller:topicController,
                    decoration: InputDecoration(
                      hintText: 'Enter Topic Name ',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15,),
                    TextField(
                      controller:descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
              actions: [
                  InkWell(
                    onTap: () {
                      final data=NotesPad(title: topicController.text, description: descriptionController.text);
                      final box=Boxes.getData();
                      box.add(data);
                      box.get(0);
                      data.save();
                      print(box.toString());
                      topicController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Add',
                                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
                  ),
               InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                 child: Text('Cancel',
                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
               ),

             

              ],
            );
          },);
}
void delete(NotesPad notesPad)async{
  await  notesPad.delete();
}
// edit one
  Future<void> editMyDialogue(BuildContext context,NotesPad notesPad,String topic,String description){
    topicController.text=topic;
    descriptionController.text=description;
  return
  showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Edit NOTES'),
              titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),
              content: Column(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller:topicController,
                    decoration: InputDecoration(
                      hintText: 'Enter Topic Name ',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 15,),
                    TextField(
                      controller:descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
              actions: [
                  InkWell(
                    onTap: () async{
                      notesPad.title=topicController.text;
                      notesPad.description=descriptionController.text;
                      notesPad.save();
                      topicController.clear();
                      descriptionController.clear();
                      
                      Navigator.pop(context);
                    },
                    child: Text('Edit',
                                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700)),
                  ),
               InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                 child: Text('Cancel',
                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
               ),

             

              ],
            );
          },);
}
  
}