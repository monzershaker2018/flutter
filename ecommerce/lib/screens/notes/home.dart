// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/notes/add.dart';
import 'package:ecommerce/screens/notes/edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var notecol = FirebaseFirestore.instance.collection("notes");

  final Stream<QuerySnapshot> _notesStream = FirebaseFirestore.instance
      .collection('notes')
      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddNotes()));
            },
            child: Icon(Icons.add)),
        appBar: AppBar(
          title: Text("Home"),
          leading: InkWell(
            child: Icon(Icons.logout),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _notesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (diss) async {
                        print(snapshot.data!.docs[index].id);
                        await notecol
                            .doc(snapshot.data!.docs[index].id)
                            .delete()
                            .then((value) async {
                          await FirebaseStorage.instance
                              .refFromURL(
                                  snapshot.data!.docs[index]['imageurl'])
                              .delete();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'great!!',
                            desc: 'Note deleted successfully',
                          ).show();
                        }).catchError((onError) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Sorry!',
                            desc: onError.toString(),
                          ).show();
                        });
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Image.network(
                                  snapshot.data!.docs[index]['imageurl'],
                                  height: 80,
                                  fit: BoxFit.cover,
                                )),
                            Expanded(
                                flex: 3,
                                child: ListTile(
                                  title:
                                      Text(snapshot.data!.docs[index]['title']),
                                  subtitle:
                                      Text(snapshot.data!.docs[index]['note']),
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                          docId: snapshot.data!.docs[index].id,
                                          list: snapshot.data!.docs[index],
                                        )));
                              },
                              child: Icon(Icons.edit),
                            )
                          ],
                        ),
                      )));
            }));
  }
}
