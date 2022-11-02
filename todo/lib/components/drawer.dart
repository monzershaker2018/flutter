// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_element, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todo/screens/categories.dart';
import 'package:todo/screens/home.dart';

import '../screens/category_by_screen.dart';
import '../serveces/category_servces.dart';

class DrawerNavi extends StatefulWidget {
  const DrawerNavi({Key? key}) : super(key: key);

  @override
  State<DrawerNavi> createState() => _DrawerNaviState();
}

class _DrawerNaviState extends State<DrawerNavi> {
  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  var _CategryService = CategryService();

  List<Widget> categoryList = []; // Always the recommended way.
  getAllCategories() async {
    var categories = await _CategryService.readCategory();
    categories.forEach((category) {
      setState(() {
        categoryList.add(InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TodoByCategory(category: category['name']))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Drawer(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const UserAccountsDrawerHeader(
                // currentAccountPicture: CircleAvatar(
                //   backgroundImage: NetworkImage(''
                //       //  "https://png.pngitem.com/pimgs/s/80-800120_user-clipart-hd-png-download.png"
                //       ),
                // ),
                accountName: Text("Monzer Shaker"),
                accountEmail: Text("Monzershaker2018@gmail.com")),
            ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              title: const Text("Categories"),
              leading: const Icon(Icons.category),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Categories())),
            ),
            Divider(thickness: 2),
            Column(
              children: categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
