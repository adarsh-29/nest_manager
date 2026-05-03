import 'package:dio/dio.dart';

class ApiService {
  static const String baseUrl = "https://dummyjson.com";
  static const String productBaseUrl = "https://api.escuelajs.co/api/v1/";

  //static const String url = "https://dummyjson.com/users?limit=10&skip=0&key=gender&value=male";

  // 1. Create a single Dio instance with the interceptor configured
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print(obj), // This ensures logs show in the console
  ));


  final Dio _dioProduct = Dio(  // this is needed as base url is changed
    BaseOptions(
      baseUrl: productBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (obj) => print(obj), // This ensures logs show in the console
  ));



  Future<List<dynamic>> fetchUsers({int limit = 20, int skip = 0}) async{

    /*final url = Uri.https(baseUrl, '/users', {'limit': '$limit', 'skip': '$skip',});
     // final response = await http.get(Uri.parse(url));
    final response = await http.get(url);


    final response = await dio.get('https://dummyjson.com/users', queryParameters: {'limit': 10});



    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['users'];
    } else {
      throw Exception('Failed to load users');
    }
     */


    try{
      // 2. Use the instance to make the call
      // The queryParameters will automatically handle the pagination
      final response = await _dio.get(
        '/users',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      // 3. In Dio, response.statusCode is checked via try-catch by default
      // and response.data is already a Map/List (not a String)
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