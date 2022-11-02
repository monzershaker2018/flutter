import 'package:flutter/material.dart';
import 'package:todo/screens/add_todo.dart';
import 'package:todo/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList ',
      home: const HomeScreen(),
    );
  }
}
