// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/news.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsByCategory extends StatefulWidget {
  final categoryName;

  const NewsByCategory({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<NewsByCategory> createState() => _NewsByCategoryState();
}

class _NewsByCategoryState extends State<NewsByCategory> {
  @override
  void initState() {
    super.initState();
    getNews();
  }

  List<News> _newList = <News>[];
  getNews() async {
    try {
      var response = await Dio().get(
          'https://newsapi.org/v2/top-headlines?country=us&category=${widget.categoryName}&apiKey=ad1b5f26c9754233a98e79b1f51a2cef');
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
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(''),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          widget.categoryName.toString().toUpperCase(),
          style: GoogleFonts.tajawal(fontSize: 20),
        ),
      ),
      body: ListView.builder(
          itemCount: _newList.length,
          itemBuilder: (BuildContext context, int i) {
            return NewsTemplate(
              title: _newList[i].title,
              author: _newList[i].author,
              description: _newList[i].description,
              urlToImage: _newList[i].urlToImage,
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
