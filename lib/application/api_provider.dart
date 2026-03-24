

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref){
  return Dio(
    BaseOptions(
      baseUrl: 'https://newsdata.io/api/1/',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      }
    )
  )..interceptors.add(ApiInterceptor());
});

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    options.queryParameters['apikey'] = 'pub_9c5389795e504700b9c8f4dd35c18dff';
    super.onRequest(options, handler);
  }
}