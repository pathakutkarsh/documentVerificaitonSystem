import 'package:flutter/material.dart';

import 'Dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF4a90e4), secondary: Colors.white)),
      home: const Dashboard(),
    );
  }
}
