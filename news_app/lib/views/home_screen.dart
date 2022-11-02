// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/models/news.dart';
import 'package:google_fonts/google_fonts.dart';

import 'news_by_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getNews();
    categoryList = _category.getCategories();
  }
// get all categories

  Category _category = Category();

  List<Category> categoryList = [];

  List<News> _newList = <News>[];
  getNews() async {
    try {
      var response = await Dio().get(
          'https://newsapi.org/v2/everything?q=apple&from=2022-09-14&to=2022-09-14&sortBy=popularity&apiKey=ad1b5f26c9754233a98e79b1f51a2cef');
      response.data['articles'].forEach((element) {
        setState(() {
          News _newsModel = News();
          _newsModel.author = element['author'];
          _newsModel.description = element['description'];
          _newsModel.publishedAt = element['publishedAt'];
          _newsModel.title = element['title'];
          _newsModel.urlToImage = element['urlToImage'];
          _newList.add(_newsModel);
        });

        print(_newList);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
                accountName: Text("Monzer Shaker"),
                accountEmail: Text("Monzershaker2018@gmail.com")),
            ListView.builder(
              shrinkWrap: true,
              itemCount: categoryList.length,
              itemBuilder: (context, i) {
                return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewsByCategory(
                            categoryName: categoryList[i].name.toString().toLowerCase()))),
                    child: ListTile(
                      title:
                          Text(categoryList[i].name.toString().toUpperCase()),
                    ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //leading: Icon(Icons.logout),
        centerTitle: true,
        title: Text(
          'Latest News',
          style: GoogleFonts.tajawal(fontSize: 20),
        ),
      ),
      body: ListView.builder(
          itemCount: _newList.length,
          itemBuilder: (BuildContext context, int i) {
            return NewsTemplate(
              title: _newList[i].title ?? Text("No Title"),
              author: _newList[i].author ?? Text("No author"),
              description: _newList[i].description ?? Text("No description"),
              urlToImage: _newList[i].urlToImage ?? Text("No urlToImage"),


            );
          }),
    );
  }
}

class NewsTemplate extends StatelessWidget {
  final author, title, description, urlToImage;
  NewsTemplate({
    Key? key,
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          //set border radius more than 50% of height and width to make circle
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: "$urlToImage",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: GoogleFonts.tajawal(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                description,
                style: GoogleFonts.tajawal(color: Colors.grey, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'Author : ',
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    author,
                    style: GoogleFonts.tajawal(),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
