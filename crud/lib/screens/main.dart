// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:crud/screens/categories.dart';
import 'package:crud/screens/products.dart';
import 'package:crud/screens/users.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myContainer("Main", Color(0xff4facfe), CategoriesScreen()),
                SizedBox(width: 10),
                myContainer(
                    "Categories", Color(0xff4facfe), CategoriesScreen()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myContainer("Products", Color(0xff4facfe), Products()),
                SizedBox(width: 10),
                myContainer("Users", Color(0xff4facfe), Users()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container myContainer(String name, var color, var screen) {
    return Container(
        width: 150,
        height: 150,
        color: color,
        child: Builder(
            builder: (context) => Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => screen),
                      );
                    },
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )));
  }
}
