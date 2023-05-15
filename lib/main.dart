import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('NoteBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Note> noteList = [];
  TextEditingController controller = TextEditingController();

  var noteBox = Hive.box<Note>('NoteBox');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 3, color: Colors.green),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Note note = Note(note: controller.text, isDone: false);
                      noteBox.add(note);
                      controller.text = '';
                    });
                  },
                  child: Text('افزودن'))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: noteBox.values.toList().length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      noteBox.values.toList()[index].note,
                      style: TextStyle(fontSize: 22),
                    ),
                    Checkbox(
                        value: noteBox.values.toList()[index].isDone,
                        onChanged: (check) {
                          setState(() {
                            noteBox.values.toList()[index].isDone = check!;
                            noteBox.values.toList()[index].save();
                            print(noteList);
                          });
                        })
                  ],
                );
              },
            ),
          )
        ],
      )),
    )

        //        ListView.builder(
        //     itemCount: 300,
        //     itemBuilder: (context, index) {
        //       return Container(
        //         margin: EdgeInsets.only(bottom: 10),
        //         height: 100,
        //         color: Colors.red,
        //         child: Text('7Learn'),
        //       );
        //     },
        //   )
        );
  }
}
