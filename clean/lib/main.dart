import 'package:clean/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Posts App',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Posts"),
        ),
        body: Center(),
      ),
    );
  }

  Future check() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
    }
  }
}
