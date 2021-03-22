import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/models/newsArticleModel.dart';
import 'package:news_app/services/webservice.dart';
import 'package:news_app/utils/constants.dart';

class NewsListState extends State<NewsList> {
  List<NewsArticleModel> _newsArticles = <NewsArticleModel>[];

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticleModel.all).then((newsArticles) => {
          setState(() => {_newsArticles = newsArticles})
        });
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    return Card(
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8,
      child: ListTile(
        title: _newsArticles[index].urlToImage == null
            ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL)
            : Image.network(_newsArticles[index].urlToImage),
        subtitle:
            Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: ListView.builder(
          itemCount: _newsArticles.length,
          itemBuilder: _buildItemsForListView,
        ));
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}
