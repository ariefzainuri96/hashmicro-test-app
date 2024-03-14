import 'dart:developer';
import 'package:dio/dio.dart';

class DioConfig {
  static Future<Dio> dioInstance() async {
    final dio = Dio();

    dio.interceptors.add(LoggingInterceptor());
    dio.options = BaseOptions(
      receiveTimeout: const Duration(milliseconds: 10000),
      connectTimeout: const Duration(milliseconds: 10000),
      contentType: 'application/json',
      headers: {"Content-Type": 'application/json'},
      baseUrl: 'https://hashmicro-test.vercel.app',
    );

    return dio;
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('\n\n');
    log('onResponse ${response.realUri}');
    log('HTTP CODE : ${response.statusCode}');
    log('Response : ${response.data}');
    log('<--- END HTTP --->');
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('\n\n');
    log('onRequest');
    log('Request Body: ${options.data}');

    log('\n\n');
    log('<--- METHOD : ${options.method} URL : ${options.baseUrl}${options.path} --->');
    log('Headers: ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('\n\n');
    log('onError');
    log('<--- HTTP CODE : ${err.response?.statusCode} URL : ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    log('Headers: ${err.requestOptions.headers}');
    log('Body: ${err.requestOptions.data}');
    log('Response: ${err.response}');
    log('<--- END HTTP');
    super.onError(err, handler);
  }
}
