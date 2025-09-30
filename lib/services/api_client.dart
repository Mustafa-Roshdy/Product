
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final _dio = Dio(BaseOptions(
    baseUrl: "https://dummyjson.com",
    headers: {
      'Content-Type': 'application/json',
    }
  )
  );

  ApiClient(){
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        responseHeader: true,
        requestBody: true,
        responseBody: true,
        enabled: kDebugMode,
        error: true,
        maxWidth: 90,
        compact: true,
      )
    );
  }

Future<Response> postData(String path , dynamic data, Map<String, dynamic>? header) async {
    
  Response response;
  response = await _dio.post(path,data: data ,options: Options(headers:header ));


  return response;
}


Future<Response> getData(String path ,  Map<String, dynamic>? header ) async {
    
  Response response;
  response = await _dio.get(path,options: Options(headers:header ));


  return response;
}


Future<Response> putData(String path , dynamic data, Map<String, dynamic>? header) async {
    
  Response response;
  response = await _dio.put(path,data: data ,options: Options(headers:header ));


  return response;
}


Future<Response> deleteData(String path ,  Map<String, dynamic>? header ) async {
    
  Response response;
  response = await _dio.delete(path,options: Options(headers:header ));


  return response;
}


}