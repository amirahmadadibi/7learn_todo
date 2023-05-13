import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> noteList = ['7learn1', '7learn2', '7learn3'];
  TextEditingController controller = TextEditingController();
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
                    noteList.add(controller.text);
                    print(noteList);
                  },
                  child: Text('افزودن'))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return Text(noteList[index]);
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
