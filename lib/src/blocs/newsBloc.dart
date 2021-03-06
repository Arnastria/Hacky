import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hacky/src/services/hackyService.dart';
import 'package:hacky/src/models/newsModel.dart';

class NewsBloc {
  Map<int, bool> _favoriteMap = Map();
  Map<int, bool> get favoriteMap => _favoriteMap;
  List<int> listNewsId;

  final _newsModelSubject = BehaviorSubject<List<NewsModel>>();
  final _newsModelFavSubject = BehaviorSubject<List<NewsModel>>();

  Stream<List<NewsModel>> get newsModelStream => _newsModelSubject.stream;
  Function(List<NewsModel>) get addNews => _newsModelSubject.sink.add;
  Function(List<NewsModel>) get addFavListNews => _newsModelFavSubject.sink.add;
  List<NewsModel> get newsModelValue => _newsModelSubject.value;
  Stream<List<NewsModel>> get newsModelFavStream => _newsModelFavSubject.stream;
  List<NewsModel> get newsModelFavValue => _newsModelFavSubject.value;

  void selectFavNews(NewsModel news) {
    toggleFav(news.id);
    List<NewsModel> newList = newsModelFavValue;
    if (favoriteMap[news.id]) {
      newList.add(news);
    } else {
      newList.remove(news);
    }
    _newsModelFavSubject.sink.add(newList);
  }

  Future<void> updateNews(int index) async {
    if (index + 20 > listNewsId.length) return;
    var futureNews = listNewsId.getRange(index, index + 20).toList().map((i) {
      _favoriteMap[i] = false;
      return fetchNewsData(i);
    });
    List<NewsModel> finished = await Future.wait(futureNews);
    newsModelValue.addAll(finished);
    newsModelValue.sort((a, b) => a.compareTo(b));
    addNews(newsModelValue);
  }

  Future<void> _initialize() async {
    addNews(List<NewsModel>());
    addFavListNews(List<NewsModel>());
    listNewsId = await fetchTopStoriesID();
    updateNews(0);
  }

  void toggleFav(int id) {
    _favoriteMap[id] ? _favoriteMap[id] = false : _favoriteMap[id] = true;
  }

  dispose() {
    _newsModelSubject.close();
    _newsModelFavSubject.close();
  }

  NewsBloc() {
    _initialize();
    print("initializing Bloc");
  }
}
