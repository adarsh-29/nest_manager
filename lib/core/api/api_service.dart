import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = "https://dummyjson.com";
  static const String productBaseUrl = "https://api.escuelajs.co/api/v1/";



  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print(obj),
  ));


  final Dio _dioProduct = Dio(
    BaseOptions(
      baseUrl: productBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print(obj),
  ));



  Future<List<dynamic>> fetchUsers({int limit = 20, int skip = 0}) async{

    try{
      final response = await _dio.get(
        '/users',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data['users'];
      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      // Handle errors (like 404, 500, or no internet)
      throw Exception('Network error: ${e.message}');



    }


  }

  Future<List<dynamic>> fetchProducts() async{
    try{
      final response = await _dioProduct.get('/products');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }


  Future<List<dynamic>> fetchNewProduct() async{
    try{
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        return response.data['products'];
      } else {
        throw Exception('Failed to create product');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }


}