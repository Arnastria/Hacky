import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hacky/src/services/hackyService.dart';
import 'package:hacky/src/models/newsModel.dart';

class NewsBloc {
  Map<int,bool> _favoriteMap = Map();

  Map<int,bool> get favoriteMap => _favoriteMap;

  final _newsModelSubject = BehaviorSubject<List<NewsModel>>();
  final _newsModelFavSubject = BehaviorSubject<List<NewsModel>>();

  Stream<List<NewsModel>> get newsModelStream => _newsModelSubject.stream;
  Function(List<NewsModel>) get addNews => _newsModelSubject.sink.add;
  Function(List<NewsModel>) get addFavListNews => _newsModelFavSubject.sink.add;
  List<NewsModel> get newsModelValue => _newsModelSubject.value;
  Stream<List<NewsModel>> get newsModelFavStream => _newsModelFavSubject.stream;
  List<NewsModel> get newsModelFavValue => _newsModelFavSubject.value;

  void selectFavNews(NewsModel news){
    toggleFav(news.id);
    List<NewsModel> newList = newsModelFavValue;
    if(favoriteMap[news.id]){
      newList.add(news);
    }else{
      newList.remove(news);
    }
    _newsModelFavSubject.sink.add(newList);
  }


  Future<void> _initialize()async{
     List<int> listNewsId = await fetchTopStoriesID();
     var futureNews = listNewsId.map((i) {
       _favoriteMap[i] = false;
       return fetchNewsData(i);
     });
     var finished = await Future.wait(futureNews);
     finished.sort((a,b)=>a.compareTo(b));
     addFavListNews(List<NewsModel>());
     addNews(finished);
  }

  void toggleFav(int id){
    _favoriteMap[id] ? _favoriteMap[id] = false : _favoriteMap[id] = true;
  }

  dispose(){
    _newsModelSubject.close();
    _newsModelFavSubject.close();
  }

  NewsBloc(){
    _initialize();
    print("initializing Bloc");
  }
}
