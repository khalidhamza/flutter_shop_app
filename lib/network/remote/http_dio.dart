import 'package:dio/dio.dart';

import 'endpoints.dart';

class Http
{
  static Dio dio = Dio(BaseOptions(
      baseUrl: apiBasePath,
      receiveDataWhenStatusError: true
  ));

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? parameters,
    String? token,
  }){
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    return dio.get(
      path,
      queryParameters: parameters
    );
  }


  static Future<Response> post ({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? parameters,
    String? token,
    String lang = 'en',
  }) async {

    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.post(
      path,
      data: data,
      queryParameters: parameters
    );
  }

  static Future<Response> put ({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? parameters,
    String? token,
    String lang = 'en',
  }) async {

    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.put(
        path,
        data: data,
        queryParameters: parameters
    );
  }


}
