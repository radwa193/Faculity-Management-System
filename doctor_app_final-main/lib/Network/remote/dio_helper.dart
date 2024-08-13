import 'package:dio/dio.dart';
//  http://10.0.0.31:54323/
class DioHelper
{
  static Dio? dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://ixwswhjospjukhbjqjzl.supabase.co/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?>? getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response?>? postData({
    required String url,
    required Map<String , dynamic>? data,
    Map<String, dynamic>? headers,
  })async {
    return dio?.post(
      url ,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response?>? putData({
    required String url,
    required Map<String , dynamic>? data,
    Map<String, dynamic>? headers,
  })async {
    return dio?.put(
      url ,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response?>? deleteData({
    required String url,
    required Map<String , dynamic>? data,
    Map<String, dynamic>? headers,
  })async {
    return dio?.delete(
      url ,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response?>? patchData({
    required String url,
    required Map<String , dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  })async {
    return dio?.patch(
      url ,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}