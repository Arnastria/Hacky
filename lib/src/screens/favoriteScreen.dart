import 'package:flutter/material.dart';
import 'package:hacky/src/blocs/provider.dart';
import 'package:hacky/src/blocs/newsBloc.dart';
import 'package:hacky/src/models/newsModel.dart';
import 'package:hacky/src/screens/newsArticle.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  NewsBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<NewsBloc>(context);

    Widget favoritesList(){
      return StreamBuilder <List<NewsModel>>(
        stream: _bloc.newsModelFavStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (context,index){
                  return Divider(color: Colors.black87);
                },
                itemBuilder: (context, index) {
                  return Container(
                      child: NewsArticle(news: snapshot.data[index],favorite: true));
                });
          }
          return CircularProgressIndicator();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Favorites"),
      ),
      body: Center(
        child: favoritesList(),
      ),
    );
  }
}
