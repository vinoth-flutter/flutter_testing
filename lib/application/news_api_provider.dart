import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/repository/news_repository.dart';

final newsApiProvider = Provider<NewsApiProvider>((ref) {
  final newsRepository = ref.read(newsRepositoryProvider);
  return NewsApiProvider(newsRepository);
});

class NewsApiProvider {
  final NewsRepository _newsRepository;
  NewsApiProvider(this._newsRepository);

  Future<Response> getArticle(String endpoint, String id) async {
    try {
      final response = await _newsRepository.getArticle(endpoint, id);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> getNews(String endpoint) async {
    try {
      final response = await _newsRepository.getNews(endpoint);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
