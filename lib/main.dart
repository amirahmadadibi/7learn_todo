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
        theme: ThemeData(fontFamily: 'koodak'),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffffffff),
              appBar: AppBar(
                toolbarHeight: 250,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: Container(
                  height: 250,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                          width: 150,
                          height: 40,
                          child: Image.asset('assets/images/logo.png')),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'تسک های امروز',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'دوشنبه ۱۲ تیر ۱۴۰۲',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xffAAB0BD)),
                                )
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Note note =
                                    Note(note: controller.text, isDone: false);
                                noteBox.add(note);

                                setState(() {
                                  controller.text = '';
                                });
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 11),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff33428DED)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'افزودن تسک',
                                        style:
                                            TextStyle(color: Color(0xff428DED)),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Color(0xff428DED),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                        child: Expanded(
                          child: TextField(
                            controller: controller,
                            style: TextStyle(
                                fontFamily: 'koodak',
                                fontSize: 20,
                                color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Color(0xff428DED)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Color(0xff428DED)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                  child: Column(
                children: [
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
                            onTap: () {
                              noteBox.values.toList()[index].isDone =
                                  !noteBox.values.toList()[index].isDone;
                              noteBox.values.toList()[index].save();
                            },
                            child: Container(
                              height: 58,
                              margin: const EdgeInsets.only(
                                  bottom: 10, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  color: (noteBox.values.toList()[index].isDone)
                                      ? Color(0xff1a007BEC)
                                      : Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  CustomChaeckBox(index,
                                      noteBox.values.toList()[index].isDone),
                                  SizedBox(
                                    width: 12,
                                  )
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
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: (widget.isCheched) ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(4)),
        child: (widget.isCheched)
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : null,
      ),
    );
  }
}
