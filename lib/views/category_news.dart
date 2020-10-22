import 'package:flutter/material.dart';
import 'package:flutter_news/helpers/news.dart';
import 'package:flutter_news/models/article_model.dart';
import 'package:flutter_news/views/home.dart';

class Category extends StatefulWidget {
  final String category;
  Category({this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading =true;
  @override
  void initState() {
    
    super.initState();
    getNews();
  }
  getNews() async{
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Flutter'),
             Text('News',style: TextStyle(color: Colors.blue),)
           ],
         ),
         actions: [
           Opacity(
             opacity: 0,
              child: Container(
               padding: EdgeInsets.symmetric(horizontal: 16),
               child: Icon(Icons.save)),
           )
         ],
         elevation: 0.0,
       ),
       body: _loading 
       ? Center(
         child: Container(
           child: CircularProgressIndicator(),),
       ) 
       : 
        SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal:16),
           child: Column(children: [
              Container(
                
                 padding: EdgeInsets.only(top:16),
                 child: ListView.builder(
                   itemCount: articles.length,
                   shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                   itemBuilder: (context, index) {
                     return BlogTile(
                       imageUrl: articles[index].urlToImage,
                       title: articles[index].title,
                       desc: articles[index].description,
                       url: articles[index].url,
                     );
                   },
                   ),
             ),  ],),
       ),
        ),
    );
  }
}