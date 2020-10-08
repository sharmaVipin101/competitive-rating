import 'package:flutter/material.dart';
import 'homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ratings",
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: HomePage(),
    );
  }
}
