// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  final String username;
  final String email;

  EditUser({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Sections'),
      ),
      body: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  initialValue: widget.username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("username"))),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  initialValue: widget.email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Email"))),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"))),
                  SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {},
                          child: Text("Save"))),
                ],
              ),
            ),
          ]),
    );
  }
}
