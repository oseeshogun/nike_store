import 'package:flutter/material.dart';

import 'collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff242424),
        fontFamily: "Rajdhani",
        brightness: Brightness.dark,
      ),
      home: Collection(),
    );
  }
}
