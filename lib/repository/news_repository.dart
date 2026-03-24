import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testing/application/api_provider.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final dio = ref.read(dioProvider);
  return NewsRepository(dio);
});

class NewsRepository {
  final Dio _dio;
  NewsRepository(this._dio);

  Future<Response> getArticle(String endpoint, String id) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: {'id': id});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> getNews(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
