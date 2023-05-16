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
        home: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff0C134F),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(
                          fontFamily: 'koodak',
                          fontSize: 20,
                          color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 3, color: Color(0xff5C469C)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 3, color: Color(0xfffD4ADFC)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Note note = Note(note: controller.text, isDone: false);
                      noteBox.add(note);

                      setState(() {
                        controller.text = '';
                      });
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: noteBox.listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: noteBox.values.toList().length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        noteBox.values.toList()[index].delete();
                      },
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.green,
                                side: BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: noteBox.values.toList()[index].isDone,
                                onChanged: (check) {
                                  noteBox.values.toList()[index].isDone =
                                      check!;
                                  noteBox.values.toList()[index].save();
                                }),
                          ),
                          Text(
                            noteBox.values.toList()[index].note,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontFamily: 'koodak'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ))
          ],
        )),
      ),
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
