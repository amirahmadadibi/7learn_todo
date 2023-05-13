import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
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
            ElevatedButton(onPressed: () {}, child: Text('افزودن'))
          ],
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
