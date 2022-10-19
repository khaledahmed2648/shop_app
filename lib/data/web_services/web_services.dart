import 'package:dio/dio.dart';

class Webservices {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token??''
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData (
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      required Map<String, dynamic> data}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token??''
    };
    return await dio.post(url, queryParameters: query, data: data);
  }
}
