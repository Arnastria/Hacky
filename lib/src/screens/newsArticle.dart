import 'package:flutter/material.dart';
import 'package:hacky/src/models/newsModel.dart';
import 'package:hacky/src/blocs/newsBloc.dart';
import 'package:hacky/src/blocs/provider.dart';

class NewsArticle extends StatefulWidget {
  final NewsModel news;
  final bool favorite;
  NewsArticle({this.news, this.favorite});

  @override
  _NewsArticleState createState() =>
      _NewsArticleState(news: news, favorite: favorite);
}

class _NewsArticleState extends State<NewsArticle> {
  final NewsModel news;
  final bool favorite;
  NewsBloc _bloc;

  _NewsArticleState({this.news, this.favorite});
  Icon _favorite_off = Icon(Icons.favorite_border);
  Icon _favorite_on = Icon(Icons.favorite, color: Colors.red);
  TextStyle titleStyle = TextStyle(fontSize: 19);
  TextStyle subStyle = TextStyle(color: Colors.black38);

  @override
  Widget build(BuildContext context) {
    Widget newsTile(NewsModel news) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right : 10),
              child: CircleAvatar(
                radius: 20,
                child: Text(news.title.substring(0,1)),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("#${news.id}",
                      style: subStyle
                  ),
                  Text(
                    news.title,
                    style: titleStyle,
                  ),
                  Text("Author : ${news.author}",
                      style: subStyle
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(news.time),
                  ),
                ],
              ),
            ),
            favorite
                ? Container()
                : Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: _bloc.favoriteMap[news.id]
                            ? _favorite_on
                            : _favorite_off,
                        onPressed: () {
                          _bloc.selectFavNews(news);
                          setState(() {});
                        })),
          ],
        ),
      );
    }

    _bloc = BlocProvider.of<NewsBloc>(context);
    return Container(
      child: newsTile(news),
    );
  }
}
