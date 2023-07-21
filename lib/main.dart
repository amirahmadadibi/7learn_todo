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
        backgroundColor: Color(0xffffffff),
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
                          color: Colors.black),
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
                      child: Container(
                        height: 58,
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 25, right: 25),
                        decoration: BoxDecoration(
                            color: Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  noteBox.values.toList()[index].note,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'koodak'),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'ساعت ۹ تا ۱۲',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xffAAB0BD),
                                      fontFamily: 'koodak'),
                                )
                              ],
                            ),
                            Spacer(),
                            CustomChaeckBox(
                                index, noteBox.values.toList()[index].isDone),
                            SizedBox(
                              width: 12,
                            )
                            // Checkbox(
                            //     checkColor: Colors.white,
                            //     activeColor: Colors.blue,
                            //     side: BorderSide(color: Colors.white),
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(4)),
                            //     value: noteBox.values.toList()[index].isDone,
                            //     onChanged: (check) {}),
                          ],
                        ),
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

class CustomChaeckBox extends StatefulWidget {
  int index;
  bool isCheched;
  CustomChaeckBox(this.index, this.isCheched, {super.key});

  @override
  State<CustomChaeckBox> createState() => _CustomChaeckBoxState();
}

class _CustomChaeckBoxState extends State<CustomChaeckBox> {
  var noteBox = Hive.box<Note>('NoteBox');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isCheched = !widget.isCheched;
        });

        noteBox.values.toList()[widget.index].isDone = widget.isCheched;
        noteBox.values.toList()[widget.index].save();
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            color: (widget.isCheched) ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(4)),
        child: (widget.isCheched)
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
